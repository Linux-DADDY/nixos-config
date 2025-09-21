{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    #sherlock.packages.${pkgs.system}.default
    sherlock-launcher
  ];
}
