{
  # Upowerd service.
  services.upower = {
    enable = true;
    criticalPowerAction = "HybridSleep";
  };

  # LoginD service
  services.logind = {
    lidSwitch = "suspend";
    extraConfig = ''
      HandlePowerKey=hybrid-sleep
    '';
  };
}
