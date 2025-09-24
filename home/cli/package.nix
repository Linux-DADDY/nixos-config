{pkgs, ...}: {
  home.packages = with pkgs; [
    tree
    bat
    lsd
  ];
}
