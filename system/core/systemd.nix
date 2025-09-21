{config, ...}: {
  # Reduce systemd timeout to speed up shutdown/reboot
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=10s
    DefaultTimeoutStopSec=10s
    DefaultTimeoutAbortSec=10s
  '';

  # Kill user processes on logout to speed up shutdown
  services.logind.extraConfig = ''
    KillUserProcesses=yes
  '';

  # Optional: More aggressive watchdog settings
  systemd.watchdog = {
    runtimeTime = "20s";
    rebootTime = "30s";
  };
}
