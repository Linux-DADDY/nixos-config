{
  wayland.windowManager.hyprland.settings = {
    dwindle = {
      pseudotile = true;
      force_split = 0;
      preserve_split = true;
      default_split_ratio = 1.2; # Slightly favor the focused window
      special_scale_factor = 0.9; # Slightly larger special workspace windows
      split_width_multiplier = 1.0;
      use_active_for_splits = true;
      smart_split = true; # Automatically choose split direction
      smart_resizing = true; # Better resizing behavior
    };
    master = {
      mfact = 0.55; # Give master window slight advantage
      orientation = "left"; # Master on left is more common
      special_scale_factor = 0.9; # Match dwindle for consistency
      new_status = "master"; # New windows become master by default
      new_on_top = true; # New windows appear at top of stack
      inherit_fullscreen = true; # Better fullscreen handling
    };
  };
}
