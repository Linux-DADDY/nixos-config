{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
  };
  home.packages = with pkgs; [
    times-newer-roman
    icomoon-feather

    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];
}
