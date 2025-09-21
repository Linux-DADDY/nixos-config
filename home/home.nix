{declarative, ...}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager configuration block
  home = {
    # Must match your NixOS system.stateVersion for compatibility
    stateVersion = "25.05";

    # Set username from your declarative configuration
    username = declarative.username;

    # Set home directory path using the username
    homeDirectory = "/home/${declarative.username}";
  };

  # Optional: Enable Home Manager's session variables
  home.sessionVariables = {
    EDITOR = "vim"; # Set default editor
    TZ = "Asia/Dhaka";
  };
}
