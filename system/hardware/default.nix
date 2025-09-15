{
  imports = [
    #    ./hardware-configuration.nix
    ./disko-luks.nix
    ./disk-mount.nix
    ./battery.nix
    ./power.nix
    ./tweaks.nix
    ./impermanence.nix
    #./impermanence-permission.nix
    #./test-impermanence.nix
  ];
}
