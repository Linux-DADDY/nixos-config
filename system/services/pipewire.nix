{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  environment.systemPackages = with pkgs; [
    helvum
    pwvucontrol # PipeWire native control
  ];
  # Enable sound with pipewire.
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      lowLatency = {
        # enable this module
        enable = true;
        # defaults (no need to be set unless modified)
        quantum = 64;
        rate = 48000;
      };
      wireplumber = {
        enable = true;
        extraConfig = {
          "10-disable-camera" = {
            "wireplumber.profiles" = {
              main."monitor.libcamera" = "disabled";
            };
          };
        };
      };
    };
    # Boost Pipewire client priorities.
    system76-scheduler.settings.processScheduler.pipewireBoost.enable = true;
  };
  # make pipewire realtime-capable
  security.rtkit.enable = true;
}
