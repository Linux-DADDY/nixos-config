{
  # Trim For SSD, fstrim.
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}
