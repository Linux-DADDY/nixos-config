{
  wayland.windowManager.hyprland.settings.animations = {
    enabled = true;

    # More dramatic bezier curves
    bezier = [
      # Strong overshoot for bouncy feel
      "bounce, 0.68, -0.55, 0.265, 1.55"

      # Sharp and quick
      "sharp, 0.23, 1, 0.32, 1"

      # Smooth ease-out
      "easeOut, 0.16, 1, 0.3, 1"

      # Elastic bounce
      "elastic, 0.175, 0.885, 0.32, 1.275"

      # Back ease for slide-in effects
      "backEase, 0.68, -0.6, 0.32, 1.6"

      # Subtle overshoot
      "subtleOvershoot, 0.25, 0.46, 0.45, 0.94"
    ];

    animation = [
      # Dramatic window entries with bounce
      "windowsIn, 1, 8, bounce, slide"
      "windowsOut, 1, 6, sharp, slide"
      "windowsMove, 1, 7, elastic, slide"

      # Smooth fades
      "fade, 1, 10, easeOut"
      "fadeIn, 1, 8, easeOut"
      "fadeOut, 1, 6, sharp"

      # Workspace switching with overshoot
      "workspaces, 1, 10, subtleOvershoot, slide"

      # Special workspace with strong effect
      "specialWorkspace, 1, 10, backEase, slidevert"

      # Animated borders
      "border, 1, 15, easeOut"
      "borderangle, 1, 20, easeOut"

      # Layer animations
      "layers, 1, 8, bounce, slide"
      "layersIn, 1, 8, bounce, slide"
      "layersOut, 1, 6, sharp, slide"
    ];
  };
}
