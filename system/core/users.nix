{
  config,
  pkgs,
  declarative,
  ...
}: {
  # Root user configuration
  users.users.root = {
    isSystemUser = false; # Makes root a login user (optional but explicit)
    hashedPassword = "$6$mZzROy37xd.Frcll$HwxYkvtgJfClK6ed0eH9GIBYl/OWh/kDIgrvyPS6rs80CMK4hXSPhoo1LXFqX8KLab1BwTAENWZPXt4/YdwY..";
  };

  # Define the user account using username from declarative config
  users.users.${declarative.username} = {
    isNormalUser = true; # Creates home directory and allows login
    description = declarative.username; # Use username as description
    home = "/home/${declarative.username}"; # Home directory path
    extraGroups = [
      "wheel" # Enables sudo privileges
      "networkmanager" # Network management permissions
      "video" # Graphics/gpu access
      "audio" # Sound/audio access
    ];
    shell = pkgs.zsh; # Uncomment to set Zsh as default shell

    # Set hashed password (generate with 'mkpasswd -m sha-512')
    hashedPassword = "$6$PNWox50JI/pX0bbG$v1vg5cKfyAxTZ8vtSO8JahMBb1L72XgOePn0sNVKSsc1LjZ3mQaGGVQiEMUdpjnjQ6YzWRg5KkssXZwir34pQ/";

    # Alternative: Use sops-nix for password management
    # passwordFile = config.sops.secrets."${declarative.username}/password".path;

    # Optional: SSH authorized keys for passwordless login
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... your-public-key-here"
    # ];
  };

  # To enable zsh.
  programs.zsh.enable = true;

  # Optional: Enable immutable users for reproducibility
  # users.mutableUsers = false; # Prevents manual user changes outside Nix

  # Optional: Disable root login for security (use sudo instead)
  # users.users.root.hashedPassword = "!"; # Disables root password
}
