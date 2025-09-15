{
  config,
  pkgs,
  username, # Add username to the arguments
  ...
}: {
  # Define the user account using the username variable
  users.users.${username} = {
    # Note: Usernames are lowercase in NixOS (adjust if needed)
    isNormalUser = true; # Creates a home directory and allows login
    description = username; # Optional human-readable description
    home = "/home/${username}"; # Home directory (default is fine, but explicit is good)
    extraGroups = [
      "wheel" # Enables sudo privileges
      "networkmanager" # Allows managing networks (useful since you enabled NetworkManager)
      "video" # For graphics access (e.g., brightness control)
      "audio" # For sound access
    ];
    # shell = pkgs.zsh; # Sets Zsh as the default shell (change to pkgs.bash if you prefer Bash)

    # Optional: Set an initial hashed password (generate with 'mkpasswd -m sha-512')
    hashedPassword = "$6$PNWox50JI/pX0bbG$v1vg5cKfyAxTZ8vtSO8JahMBb1L72XgOePn0sNVKSsc1LjZ3mQaGGVQiEMUdpjnjQ6YzWRg5KkssXZwir34pQ/"; # Replace with your hashed password (run 'mkpasswd' to generate)
    # Sops nix
    #passwordFile = config.sops.secrets."${username}/password".path;

    # Optional: Authorized SSH keys (for passwordless login)
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... your-public-key-here"
    # ];
  };

  # Optional: Disable mutable users (prevents manual changes outside Nix)
  #users.mutableUsers = false; # Enforces declarative user management (recommended for reproducibility)

  # Optional: If this is your only user, disable root login for security
  # users.users.root.hashedPassword = "!";  # Disables root password (use sudo instead)
  #users.users.root = {
  #  hashedPassword = "$6$RRoOQt5e9qkb2ObI$Kq1mit67zmxZzfXZE5xxP.5.hlj/7W/7Bt89Ws196psZA.P2eBBgBBHdt5hbKCk2esR8uBmV28GcZCqJThlD40";
  #};
}
