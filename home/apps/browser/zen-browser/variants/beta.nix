{
  pkgs,
  inputs,
  ...
}: {
  # home.nix
  imports = [
    inputs.zen-browser.homeModules.default
    #inputs.zen-browser.homeModules.beta
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
