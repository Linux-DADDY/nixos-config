{
  imports = [
    ./systemd-boot.nix
    ./users.nix
    #./test-users.nix
    ./config.nix
    ./amd.nix
    #./amdvlk.nix ##NOTE: LAGGY
    #./plymouth.nix ##NOTE: For some reason i am loving the systemd code.
    ./systemd.nix
  ];
}
