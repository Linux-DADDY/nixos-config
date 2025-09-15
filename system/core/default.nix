{
  imports = [
    ./systemd-boot.nix
    ./users.nix
    #./test-users.nix
    ./config.nix
    #./amd.nix
    ./amdvlk.nix
    #./plymouth.nix ##NOTE: For some reason i am loving the systemd code.
    ./systemd.nix
  ];
}
