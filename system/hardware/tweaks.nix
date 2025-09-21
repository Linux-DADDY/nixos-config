{
  # Trim For SSD, fstrim.
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/etc/nixos/";
  };
}
