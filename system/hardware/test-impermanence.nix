{
  config,
  lib,
  ...
}: {
  boot.initrd.systemd.enable = true;

  environment.persistence."/persist" = {
    hideMounts = true;
    # REMOVE THE 'removePrefixDirectory' LINE

    directories = [
      # System State (Critical for functionality)
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/NetworkManager"
      "/var/lib/private/NetworkManager"
      "/var/lib/bluetooth" # Don't forget this if you use Bluetooth!

      # Service State (Add based on what you use)
      "/var/lib/libvirt"
      "/var/lib/sddm"
      "/var/lib/waydroid"

      # Network
      "/etc/NetworkManager/system-connections"

      # Logs (Optional: keeps old logs across reboots)
      "/var/log"

      # SSH Host Keys - Do it this way instead of via services.openssh if you prefer
      "/etc/ssh"
    ];

    files = [
      "/etc/machine-id"
      "/var/lib/systemd/timesync/clock"
    ];
  };

  # Now, define your user's persisted files and directories
  environment.persistence."/persist".users.${config.users.users.Linux-DADDY.name} = {
    directories = [
      # XDG User Directories
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Templates"
      "Public"

      # Application Data & State
      ".local/share/applications"
      ".local/share/direnv"
      ".local/share/fish"
      ".local/share/zoxide"
      ".local/state/nvim"
      ".local/state/bash"
      ".local/state/wireplumber"
      ".local/state/zsh"

      # Development & Tooling
      "Projects"
      ".cargo"
      ".rustup"
      ".npm"
      ".cache/nix"
      ".cache/nvim"
      ".mozilla/firefox"
      ".config/Code/User/History"
      ".config/VSCodium/User/History"

      # Security & Keys
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".local/share/keyrings";
        mode = "0700";
      }
      {
        directory = ".nixops";
        mode = "0700";
      }
      {
        directory = ".config/gh";
        mode = "0700";
      }

      # Gaming - Heroic and Bottles
      ".config/heroic"
      ".local/share/bottles"
      ".local/share/Steam" # Steam
      ".minecraft" # Minecraft

      # Communication
      ".config/discord"
      ".config/Signal"
      ".config/Element"
      ".config/spotify"
    ];

    files = [
      ".screenrc"
      ".gitconfig"
      ".bashrc"
      ".zshrc"
      ".local/state/wireplumber/wireplumber.state"
    ];
  };

  # RECOMMENDED: The better way to handle SSH host keys
  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/persist/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];
  };
}
