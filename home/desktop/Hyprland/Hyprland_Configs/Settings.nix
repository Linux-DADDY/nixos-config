{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; #FIXME: Does not work properly, Enabled this because i want to try it.
    systemd.variables = ["--all"];
    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        # "DP-1,transform,1"
        # "workspace=eDP-1,1"

        # HDMI Monitor setup
        "HDMI-A-1,1920x1080@60,1920x0,1"
        # "workspace=HDMI-A-1,11"

        "Unknown-1,disable"
      ];

      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}
