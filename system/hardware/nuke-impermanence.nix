{
  pkgs,
  lib,
  declarative,
  ...
}: let
  persistPath = declarative.persistPath;

  # Btrfs-based nuke script that recreates subvolumes for true impermanence
  nukeScript = pkgs.writeShellScript "btrfs-nuke-impermanent" ''
    set -euo pipefail

    echo "🧹 Starting btrfs impermanence cleanup..."

    # Mount the encrypted btrfs root
    LUKS_DEV="/dev/mapper/cryptroot"
    MOUNT_POINT="/mnt/btrfs-root"

    # Create temporary mount point
    mkdir -p "$MOUNT_POINT"

    # Mount the btrfs root (not any subvolume)
    if ! mount "$LUKS_DEV" "$MOUNT_POINT" -o subvolid=5,compress=zstd:1,ssd,discard=async,space_cache=v2; then
      echo "❌ Failed to mount btrfs root"
      exit 1
    fi

    cd "$MOUNT_POINT"

    # Function to recreate a subvolume
    recreate_subvolume() {
      local subvol_name="$1"
      local backup_suffix="$2"

      echo "🔄 Recreating subvolume: $subvol_name"

      # Create backup snapshot if subvolume exists
      if [[ -d "$subvol_name" ]]; then
        echo "  📸 Creating backup snapshot: $subvol_name$backup_suffix"
        btrfs subvolume snapshot "$subvol_name" "$subvol_name$backup_suffix" || true

        echo "  🗑️  Deleting old subvolume: $subvol_name"
        btrfs subvolume delete "$subvol_name" || true
      fi

      echo "  ✨ Creating fresh subvolume: $subvol_name"
      btrfs subvolume create "$subvol_name"

      # Set appropriate permissions
      case "$subvol_name" in
        "home")
          chmod 755 "$subvol_name"
          ;;
        "root")
          chmod 755 "$subvol_name"
          ;;
        *)
          chmod 755 "$subvol_name"
          ;;
      esac
    }

    # Recreate impermanent subvolumes (keeping nix, persist, log, swap)
    recreate_subvolume "root" "-old-$(date +%Y%m%d-%H%M%S)"
    recreate_subvolume "home" "-old-$(date +%Y%m%d-%H%M%S)"

    # Clean up old backup snapshots (keep only last 3)
    echo "🧹 Cleaning up old snapshots..."
    find . -maxdepth 1 -name "*-old-*" -type d | sort | head -n -3 | while read -r old_snapshot; do
      if [[ -n "$old_snapshot" ]]; then
        echo "  🗑️  Removing old snapshot: $old_snapshot"
        btrfs subvolume delete "$old_snapshot" 2>/dev/null || true
      fi
    done

    # Create essential directories in fresh root subvolume
    echo "📁 Creating essential directories in fresh root subvolume..."

    # Create basic root filesystem structure
    mkdir -p root/{etc,var,usr,opt,srv,run,tmp}
    mkdir -p root/var/{tmp,cache,lib,log,opt,spool}
    mkdir -p root/usr/{bin,lib,share,local}
    mkdir -p root/tmp
    chmod 1777 root/tmp
    chmod 1777 root/var/tmp

    # Create user directory structure in fresh home subvolume
    echo "🏠 Setting up user home in fresh home subvolume..."
    mkdir -p "home/${declarative.username}"
    chown 1000:100 "home/${declarative.username}" 2>/dev/null || true
    chmod 700 "home/${declarative.username}" 2>/dev/null || true

    cd /
    umount "$MOUNT_POINT"
    rmdir "$MOUNT_POINT"

    echo "✅ Btrfs impermanence cleanup completed!"
    echo "📊 Fresh subvolumes created - system will be completely clean on next boot"
  '';

  # Lightweight initrd cleanup script
  initrdNukeScript = ''
    echo "🚀 Initrd: Preparing btrfs impermanence cleanup..."

    # Create mount point
    mkdir -p /mnt-btrfs-root

    # Mount btrfs root filesystem
    if mount /dev/mapper/cryptroot /mnt-btrfs-root -o subvolid=5,compress=zstd:1; then
      cd /mnt-btrfs-root

      # Quick cleanup of temporary files
      if [[ -d "root/tmp" ]]; then
        rm -rf root/tmp/* 2>/dev/null || true
      fi
      if [[ -d "root/var/tmp" ]]; then
        rm -rf root/var/tmp/* 2>/dev/null || true
      fi

      # Optionally recreate subvolumes here for even more thorough cleanup
      # (Uncomment the lines below for full subvolume recreation at boot)
      #
      # timestamp=$(date +%Y%m%d-%H%M%S)
      # if [[ -d "root" ]]; then
      #   btrfs subvolume snapshot root root-old-$timestamp || true
      #   btrfs subvolume delete root || true
      #   btrfs subvolume create root
      #   mkdir -p root/{etc,var,usr,opt,srv,run,tmp}
      #   chmod 1777 root/tmp
      # fi
      #
      # if [[ -d "home" ]]; then
      #   btrfs subvolume snapshot home home-old-$timestamp || true
      #   btrfs subvolume delete home || true
      #   btrfs subvolume create home
      #   mkdir -p home/${declarative.username}
      # fi

      cd /
      umount /mnt-btrfs-root
    fi

    rmdir /mnt-btrfs-root 2>/dev/null || true
    echo "✅ Initrd cleanup completed"
  '';
in {
  programs.fuse.userAllowOther = true;
  users.users.${declarative.username}.extraGroups = ["fuse"];

  boot.initrd = {
    supportedFilesystems = ["btrfs"];
    kernelModules = ["btrfs" "dm-mod" "dm-crypt"];
    extraUtilsCommands = ''
      copy_bin_and_libs ${pkgs.btrfs-progs}/bin/btrfs
    '';

    # Initrd cleanup - runs before root filesystem switch
    postDeviceCommands = lib.mkAfter initrdNukeScript;
  };

  environment.persistence.${persistPath} = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"
      {
        directory = "/etc/ssh";
        mode = "0755";
      }

      # ADD USER DIRECTORIES HERE
      "/home/${declarative.username}/Downloads"
      "/home/${declarative.username}/Pictures"
      "/home/${declarative.username}/Documents"
      "/home/${declarative.username}/Videos"
      "/home/${declarative.username}/Desktop"
      "/home/${declarative.username}/Public"
      "/home/${declarative.username}/Templates"
      "/home/${declarative.username}/.gnupg"
      "/home/${declarative.username}/.local/share/keyrings"
      "/home/${declarative.username}/.config/git"
      "/home/${declarative.username}/.zen"
      "/home/${declarative.username}/.cache/zen"
      "/home/${declarative.username}/.local/share/applications"
      "/home/${declarative.username}/.local/share/icons"
      "/home/${declarative.username}/.config/fontconfig"
      "/home/${declarative.username}/Games"
      "/home/${declarative.username}/Game-Mods"
      "/home/${declarative.username}/Appimages"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  systemd.tmpfiles.rules = [
    "d ${persistPath} 0755 root root -"
    "d ${persistPath}/home 0755 root root -"
    "d ${persistPath}/home/${declarative.username} 0700 ${declarative.username} users -"

    # Create all subdirectories
    "d ${persistPath}/home/${declarative.username}/Downloads 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Pictures 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Documents 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Videos 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Desktop 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Public 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Templates 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.gnupg 0700 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.local/share/keyrings 0700 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.config/git 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.zen 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.cache/zen 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.local/share/applications 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.local/share/icons 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.config/fontconfig 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Games 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Game-Mods 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Appimages 0755 ${declarative.username} users -"
  ];

  # Systemd service for manual/scheduled full cleanup
  systemd.services.btrfs-nuke-impermanent = {
    description = "Btrfs subvolume recreation for true impermanence";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${nukeScript}";
      RemainAfterExit = false;
      StandardOutput = "journal";
      StandardError = "journal";
    };
  };

  # Optional: Timer for periodic cleanup (disabled by default)
  systemd.timers.btrfs-nuke-impermanent = {
    description = "Periodic btrfs impermanence cleanup";
    # wantedBy = [ "timers.target" ];  # Uncomment to enable
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  # Add manual nuke commands to system packages
  environment.systemPackages = [
    # Full nuclear option - recreates subvolumes
    (pkgs.writeShellScriptBin "nuke-system-full" ''
      echo "💥 NUCLEAR OPTION: This will recreate root and home subvolumes!"
      echo "⚠️  ALL non-persistent data will be permanently lost!"
      echo "Press Ctrl+C within 10 seconds to cancel..."
      sleep 10
      ${nukeScript}
      echo ""
      echo "🔄 Reboot required for changes to take effect"
      echo "Run: sudo reboot"
    '')

    # Lighter cleanup option
    (pkgs.writeShellScriptBin "nuke-system-light" ''
      echo "🧹 Light cleanup: removing temporary files and caches..."
      find /tmp -mindepth 1 -delete 2>/dev/null || true
      find /var/tmp -mindepth 1 -delete 2>/dev/null || true
      find /home -name ".cache" -type d -exec find {} -mindepth 1 -delete \; 2>/dev/null || true
      echo "✅ Light cleanup completed!"
    '')

    # Show subvolume status
    (pkgs.writeShellScriptBin "show-subvolumes" ''
      echo "📊 Current btrfs subvolumes:"
      sudo btrfs subvolume list /
      echo ""
      echo "💾 Disk usage by subvolume:"
      sudo btrfs fi usage /
    '')
  ];

  fileSystems.${persistPath}.neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  security.sudo.extraConfig = "Defaults lecture = never";
}
