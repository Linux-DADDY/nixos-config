{
  pkgs,
  inputs,
  ...
}: {
  # home.nix
  imports = [
    inputs.zen-browser.homeModules.twilight
    # inputs.zen-browser.homeModules.twilight-official
  ];
  programs.zen-browser = {
    enable = true;
    languagePacks = ["en-US"];
    nativeMessagingHosts = [pkgs.firefoxpwa];
    profiles = {
      "default" = {
        # Changed profile name as requested
        id = 0;
        name = "ZEN-DADDY";
        isDefault = true;
      };
    };
  };
}
