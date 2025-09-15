{
  config,
  pkgs,
  username,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs this to match your NixOS stateVersion
  home.stateVersion = "25.05"; # Keep in sync with system.stateVersion in configuration.nix
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Enable and configure programs
  programs.git = {
    enable = true;
    #  userName = "Your Name"; # Change to your Git username
    #  userEmail = "your.email@example.com"; # Change to your email
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Optional: Enable Home Manager's session variables
  home.sessionVariables = {
    EDITOR = "vim"; # Set default editor
    TZ = "Asia/Dhaka";
  };
}
