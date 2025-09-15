{pkgs, ...}: {
  # Base power management (let TLP take the wheel)
  powerManagement.enable = true;

  # Disable conflicting services
  services.power-profiles-daemon.enable = false;

  # Enable TLP and configure CPU + USB policies
  services.tlp = {
    enable = true;
    settings = {
      # CPU frequency scaling governors
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Energy/performance tuning
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      # Performance caps (percentages)
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100; # Full power when plugged in

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50; # Keeps temps & fan noise sane

      # USB auto-suspend (1 = enabled)
      #USB_AUTOSUSPEND = 1;
    };
  };

  # Other power-tweakers to keep OFF when using TLP:
  # powerManagement.powertop.enable = false;
  # powerManagement.cpuFreqGovernor = null;
  # services.system76-scheduler.enable = false;
}
