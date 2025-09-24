{
  pkgs,
  lib,
  declarative,
  ...
}: let
  persistPath = declarative.persistPath;

  # Streamlined initrd cleanup script
  initrdNukeScript = ''
    echo "🚀 Initrd: Starting btrfs impermanence cleanup..."

    # Wait for LUKS device
    if [ ! -e /dev/mapper/cryptroot ]; then
        echo "❌ LUKS device not found - trying to open..."
        cryptsetup luksOpen /dev/disk/by-label/luks cryptroot || {
            echo "❌ Failed to open LUKS device"
            exit 1
        }
    fi

    mkdir -p /mnt-btrfs-root
    if mount /dev/mapper/cryptroot /mnt-btrfs-root -o subvolid=5,compress=zstd:1; then
      cd /mnt-btrfs-root
      timestamp=$(date +%Y%m%d-%H%M%S)

      # Function to safely delete subvolumes
      delete_subvolume_recursively() {
          local subvol_path="$1"
          btrfs subvolume list -o "$subvol_path" 2>/dev/null | cut -f9 -d' ' | while read subvolume; do
              echo "Deleting nested subvolume: /$subvolume"
              btrfs subvolume delete "/$subvolume" 2>/dev/null || true
          done
          btrfs subvolume delete "$subvol_path" 2>/dev/null || true
      }

      # Recreate root subvolume
      if [[ -d "root" ]]; then
          echo "🔄 Recreating root subvolume..."
          btrfs subvolume snapshot root "root-old-$timestamp" 2>/dev/null || true
          delete_subvolume_recursively "root"
          btrfs subvolume create root
          mkdir -p root/{etc,var/tmp,usr,tmp}
          chmod 1777 root/tmp root/var/tmp
      else
          btrfs subvolume create root
          mkdir -p root/{etc,var/tmp,usr,tmp}
          chmod 1777 root/tmp root/var/tmp
      fi

      # Recreate home subvolume
      if [[ -d "home" ]]; then
          echo "🔄 Recreating home subvolume..."
          btrfs subvolume snapshot home "home-old-$timestamp" 2>/dev/null || true
          delete_subvolume_recursively "home"
          btrfs subvolume create home
      else
          btrfs subvolume create home
      fi

      # Clean old snapshots (keep last 3)
      for subvol in root home; do
          find . -maxdepth 1 -name "$subvol-old-*" -type d 2>/dev/null | sort -r | tail -n +4 | while read old_snapshot; do
              btrfs subvolume delete "$old_snapshot" 2>/dev/null || true
          done
      done

      cd / && umount /mnt-btrfs-root
      echo "✅ Impermanence setup completed"
    else
      echo "❌ Failed to mount btrfs root"
      exit 1
    fi
    rmdir /mnt-btrfs-root 2>/dev/null || true
  '';
in {
  programs.fuse.userAllowOther = true;
  users.users.${declarative.username}.extraGroups = ["fuse"];

  boot.initrd = {
    supportedFilesystems = ["btrfs"];
    kernelModules = ["btrfs" "dm-mod" "dm-crypt"];
    extraUtilsCommands = ''
      copy_bin_and_libs ${pkgs.btrfs-progs}/bin/btrfs
      copy_bin_and_libs ${pkgs.cryptsetup}/bin/cryptsetup
    '';
    postDeviceCommands = lib.mkAfter initrdNukeScript;
  };

  environment.persistence.${persistPath} = {
    enable = true;
    hideMounts = true;
    directories = [
      # System directories
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"
      {
        directory = "/etc/ssh";
        mode = "0755";
      }
    ];

    # User-specific persistence with proper ownership
    users.${declarative.username} = {
      directories = [
        # User data directories
        "Downloads"
        "Pictures"
        "Documents"
        "Videos"
        "Desktop"
        "Public"
        "Templates"
        "Games"
        "Game-Mods"
        "Appimages"

        # Security & keys (with restrictive permissions)
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }

        # Application configs
        ".config/git"
        ".zen"
        ".mozilla"
        ".config/BeeperTexts"

        # Desktop environment configs
        ".config/alacritty"
        ".config/hypr"
        ".config/hyprpanel"
        ".config/hyprshade"
        ".config/kitty"
        ".config/mpv"
        ".config/nemo"
        ".config/gtk-3.0"
        ".config/gtk-4.0"
        {
          directory = ".config/dconf";
          mode = "0700";
        }
        ".config/fontconfig"

        # Input method configs
        {
          directory = ".config/fcitx";
          mode = "0700";
        }
        {
          directory = ".config/fcitx5";
          mode = "0700";
        }
        {
          directory = ".config/ibus";
          mode = "0700";
        }

        # System integration
        ".config/systemd"
        ".config/environment.d"
        ".local/share/applications"
        ".local/share/icons"

        # Local directories
        ".local/share"
        {
          directory = ".local/state";
          mode = "0700";
        }
        ".cache"

        # Specific cache directories
        ".cache/zen"
        ".cache/kitty"
      ];

      files = [
        ".config/user-dirs.dirs"
        ".config/user-dirs.locale"
      ];
    };

    files = [
      "/etc/machine-id"
    ];
  };

  # Minimal tmpfiles rules - let impermanence handle most directory creation
  systemd.tmpfiles.rules = [
    # Only create the base persist directory structure
    "d ${persistPath} 0755 root root -"
    "d ${persistPath}/home 0755 root root -"

    # The user home directory itself should be created by the system
    # but we ensure it has correct permissions
    "d /home/${declarative.username} 0755 ${declarative.username} users -"
  ];

  # Add a systemd service to fix ownership after boot
  systemd.services.fix-home-permissions = {
    description = "Fix home directory permissions after impermanence setup";
    after = ["local-fs.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # Fix ownership of home directory and immediate subdirectories
      ${pkgs.coreutils}/bin/chown -R ${declarative.username}:users /home/${declarative.username}

      # Ensure proper permissions for security-sensitive directories
      if [ -d "/home/${declarative.username}/.gnupg" ]; then
        ${pkgs.coreutils}/bin/chmod 0700 /home/${declarative.username}/.gnupg
        ${pkgs.coreutils}/bin/chown -R ${declarative.username}:users /home/${declarative.username}/.gnupg
      fi

      if [ -d "/home/${declarative.username}/.local/share/keyrings" ]; then
        ${pkgs.coreutils}/bin/chmod 0700 /home/${declarative.username}/.local/share/keyrings
        ${pkgs.coreutils}/bin/chown -R ${declarative.username}:users /home/${declarative.username}/.local/share/keyrings
      fi

      # Fix SSH directory if it exists in home
      if [ -d "/home/${declarative.username}/.ssh" ]; then
        ${pkgs.coreutils}/bin/chmod 0700 /home/${declarative.username}/.ssh
        ${pkgs.coreutils}/bin/chown -R ${declarative.username}:users /home/${declarative.username}/.ssh
      fi
    '';
  };

  # Utility commands
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "show-subvolumes" ''
      echo "📊 Current btrfs subvolumes:"
      sudo btrfs subvolume list /
      echo -e "\n💾 Disk usage:"
      sudo btrfs fi usage /
    '')

    (pkgs.writeShellScriptBin "fix-home-perms" ''
      echo "🔧 Fixing home directory permissions..."
      sudo chown -R ${declarative.username}:users /home/${declarative.username}
      echo "✅ Home directory permissions fixed"
    '')
  ];

  fileSystems.${persistPath}.neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  security.sudo.extraConfig = "Defaults lecture = never";
}
