{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      kb_variant = ",qwerty";
      kb_model = "";
      kb_options = "";
      kb_rules = "";

      follow_mouse = 1;
      repeat_delay = 140;
      repeat_rate = 30;
      numlock_by_default = true;
      accel_profile = "flat";
      sensitivity = 0;
      force_no_accel = 1;
      touchpad = {
        natural_scroll = 1;
      };
    };

    cursor = {
      enable_hyprcursor = true;
    };

    gestures = {
      workspace_swipe = 1;
      workspace_swipe_fingers = 3;
      workspace_swipe_distance = 200;
      workspace_swipe_min_speed_to_force = 100;
    };

    render = {
      # Enables explicit sync support.
      explicit_sync = 1;
    };

    debug = {
      damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
    };

    misc = {
      vfr = true; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
      vrr = 0; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
      #disable_hyprland_logo = true;
      #disable_splash_rendering = true;
      disable_hyprland_logo = false;
      disable_splash_rendering = false;
    };

    #NOTE: Hyprland environment variables won't conflict with your home-manager environment variables.
    env = [
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      "HYPRCURSOR_SIZE,40"

      # Core Wayland/Hyprland setup
      "XDG_SESSION_TYPE,wayland"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # Mozilla/Firefox Wayland support
      "MOZ_ENABLE_WAYLAND,1"

      # NixOS Wayland support
      "NIXOS_OZONE_WL,1"

      # Qt applications
      "QT_QPA_PLATFORM,wayland;xcb" # Falls back to xcb if wayland fails
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

      # Electron apps (Discord, VS Code, etc.)
      "ELECTRON_OZONE_PLATFORM_HINT,auto"

      # Disable Qt5 compatibility layer (performance)
      "DISABLE_QT5_COMPAT,1"

      # Clean directory environment log format
      "DIRENV_LOG_FORMAT,"

      # Wayland rendering backends
      "WLR_BACKEND,vulkan"
      "WLR_RENDERER,vulkan"

      # Hardware cursor support (uncomment if you have cursor issues)
      # "WLR_NO_HARDWARE_CURSORS,1"

      # SDL applications
      "SDL_VIDEODRIVER,wayland"

      # Clutter (GNOME apps)
      "CLUTTER_BACKEND,wayland"

      # GDK (GTK apps)
      "GDK_BACKEND,wayland,x11" # Falls back to x11 if needed

      # Java applications
      "_JAVA_AWT_WM_NONREPARENTING,1"

      # Additional optimizations you might want to add:

      # Better font rendering
      # "FREETYPE_PROPERTIES,truetype:interpreter-version=40"

      # AMD GPU hardware acceleration
      "LIBVA_DRIVER_NAME,radeonsi"
      "VDPAU_DRIVER,radeonsi"

      # For better HiDPI support
      # "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      # "QT_SCALE_FACTOR,1.5"       # Adjust as needed

      # If you have issues with some apps
      # "QT_QPA_PLATFORMTHEME,qt5ct"
      # "QT_STYLE_OVERRIDE,kvantum"
    ];
  };
}
