{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    equibop
    ayugram-desktop
    mission-center
    kdePackages.okular
    viewnior
    unzip
    nemo-fileroller
    file-roller
    nemo-with-extensions
    nemo-preview
    folder-color-switcher
    rustdesk-flutter
    #brave #NOTE: Worst browser as it have some leak of gpu support.
    ungoogled-chromium
    #heroic
    legcord
    megabasterd
  ];
}
