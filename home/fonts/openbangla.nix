{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
    };
    fcitx5.addons = with pkgs; [
      #      fcitx5-gtk
      # fcitx5-with-addons
      fcitx5-openbangla-keyboard # Add this for Bengali input
      # fcitx5-chinese-addons # if you need Chinese
      #  fcitx5-mozc # if you need Japanese
      # other addons as needed
    ];
  };

  # Environment variables remain the same
  home.sessionVariables = {
    #    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    INPUT_METHOD = "fcitx";
    SDL_IM_MODULE = "fcitx";
  };
}
