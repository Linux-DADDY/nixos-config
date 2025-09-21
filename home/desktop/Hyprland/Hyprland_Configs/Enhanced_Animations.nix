{
  wayland.windowManager.hyprland.settings.animations = {
    enabled = true;

    # Enhanced bezier curves for smoother motion
    bezier = [
      # Smooth and natural feeling
      "myBezier, 0.05, 0.9, 0.1, 1.05"

      # Slight overshoot for playful feel
      "overshot, 0.05, 0.9, 0.1, 1.1"

      # Quick and snappy
      "snappy, 0.1, 1, 0.1, 1"

      # Material Design 3 inspired
      "md3_standard, 0.2, 0, 0, 1"
      "md3_decel, 0.05, 0.7, 0.1, 1"
      "md3_accel, 0.3, 0, 0.8, 0.15"

      # Smooth workspace transitions
      "workspaceSmooth, 0.25, 0.46, 0.45, 0.94"

      # Elastic effect for special cases
      "elastic, 0.68, -0.55, 0.265, 1.55"
    ];

    animation = [
      # Window animations - smooth entry/exit
      "windowsIn, 1, 7, myBezier, slide"
      "windowsOut, 1, 7, myBezier, slide"
      "windowsMove, 1, 6, myBezier, slide"

      # Fade animations
      "fade, 1, 8, md3_decel"
      "fadeIn, 1, 8, md3_decel"
      "fadeOut, 1, 8, md3_accel"

      # Workspace switching - smooth and fast
      "workspaces, 1, 8, workspaceSmooth, slide"

      # Special workspace with slight overshoot
      "specialWorkspace, 1, 8, overshot, slidevert"

      # Border animations
      "border, 1, 12, md3_decel"
      "borderangle, 1, 12, md3_decel"

      # Layer animations for popups/overlays
      "layers, 1, 6, md3_decel, slide"
      "layersIn, 1, 6, md3_decel, slide"
      "layersOut, 1, 6, md3_accel, slide"
    ];
  };
}
