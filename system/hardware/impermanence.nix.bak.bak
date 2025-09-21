{
  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      # System state
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"

      # Network
      "/etc/NetworkManager/system-connections"

      # SSH host keys (important for server identity)
      {
        directory = "/etc/ssh";
        mode = "0755";
      }
    ];

    files = [
      "/etc/machine-id"
      # Add if you use custom hosts file entries
      # "/etc/hosts"
    ];
  };
}
