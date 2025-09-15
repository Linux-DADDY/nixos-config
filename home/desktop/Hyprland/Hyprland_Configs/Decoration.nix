{
  wayland.windowManager.hyprland.settings.decoration = {
    rounding = 10;
    blur = {
      enabled = true;
      size = 7;
      passes = 1;
      new_optimizations = true;
      xray = false; # Don't blur behind transparent windows
      ignore_opacity = false; # Respect window opacity for blur
    };
  };
}
