{
  pkgs,
  declarative,
  ...
}: {
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://numtide.cachix.org"
      "https://pre-commit-hooks.cachix.org"
      "https://chaotic-nyx.cachix.org"
      "https://nix-gaming.cachix.org"
    ];

    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];

    # Automatically optimize store during builds
    auto-optimise-store = true;

    # Build in sandbox for reproducibility
    sandbox = true;
  };

  #  Use Xanmod kernel
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  #boot.kernelPackages = pkgs.linuxPackages_xanmod_stable; # stable version

  # Set your time zone.
  # time.hardwareClockInLocalTime = true;
  time.timeZone = declarative.timeZone;
  services.timesyncd.enable = true;

  services.scx = {
    enable = true; # by default uses scx_rustland scheduler
    package = pkgs.scx.rustscheds;
    # Optional: specify which scheduler to use
    scheduler = "scx_rustland";
    #scheduler = "scx_bpfland"; # or "scx_rustland for gaming", etc.
  };

  # Appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Enable user_allow_other for FUSE (required for home.persistence allowOther = true)
  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  # Command not found
  programs.command-not-found.enable = true;

  # Freefall
  services.freefall = {
    enable = true;
    #devices = [
    # "/dev/sda"
    #];
  };

  # Enable flakes and new nix command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}
