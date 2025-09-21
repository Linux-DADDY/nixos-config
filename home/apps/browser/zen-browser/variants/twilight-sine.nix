{
  pkgs,
  inputs,
  ...
}: {
  # home.nix
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;
    languagePacks = ["en-US"];
    nativeMessagingHosts = [pkgs.firefoxpwa];
    profiles = {
      "default" = {
        id = 0;
        name = "ZEN-DADDY";
        isDefault = true;

        # If the module supports extraConfig for profiles
        extraConfig = ''
          ${builtins.readFile (builtins.fetchurl {
            url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
            sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
          })}
        '';
      };
    };
  };
}
