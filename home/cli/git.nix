{
  # For system-wide or per-user via configuration.nix
  programs.git = {
    enable = true;
    userName = "Linux-DADDY";
    userEmail = "nahianadnan1234@proton.me";

    # Optional: extra config
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      #credential.helper = "store"; # Stores credentials in ~/.git-credentials (plaintext!)
    };
  };
}
