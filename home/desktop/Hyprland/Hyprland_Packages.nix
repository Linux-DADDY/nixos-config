{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wlogout
    yad
    psmisc
    pamixer
    libnotify
    brightnessctl
    wl-clipboard
    cliphist
    wlroots
    slurp
    hyprpicker
    imagemagick
    grim
    swaylock-effects
    # hyprpolkitagent
    gpustat
    hyprpanel #inputs.hyprpanel.packages.${pkgs.system}.default
    ags
    #plugins
    # hyprlandPlugins.hyprspace
    nwg-dock-hyprland

    #NOTE: Multi monitor pkg.
    hyprsome

    #NOTE: For screenshot script.
    slop
    ffcast
    xclip
    xdg-user-dirs

    #NOTE: Wallpapers with pyprland
    swww
  ];
}
