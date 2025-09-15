{
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float,class:^(org.gnome.FileRoller)$"
    "center,class:^(org.gnome.FileRoller)$"
    "size 450 250,class:^(org.gnome.FileRoller)$"

    "float, class:(kitty-float)"
    "center, class:(kitty-float)"
    "size 80% 70%, class:(kitty-float)"

    "opacity 0.8 0.8,class:^(kitty)$"

    "workspace 1 ,opacity 1.0,class:(kitty)"
    "workspace 6 silent,class:(virt-manager)"
    "workspace 2 ,class:(vivaldi-stable)"
    "workspace 3 silent,class:(nemo)"
    "workspace 4 silent,class:(Beeper)"
    "workspace 4 silent,opacity 1.0,class:(zen-alpha)"
    # "workspace 6 silent,class:(beepertexts)"
    "workspace 4 ,class:(discord)"
    "workspace 9 silent,class:(rambox)"
    "workspace 3 ,class:(mpv)"

    # Fullscreen
    # "fullscreen,class:(mpv)"
    # "fullscreen,class:(com.stremio.stremio)"

    # Bottles floating configuration
    "float, class:(com.usebottles.bottles)"
    "center, class:(com.usebottles.bottles)"
    "size 80% 70%, class:(com.usebottles.bottles)" # Percentage-based sizing
    "minsize 800 600, class:(com.usebottles.bottles)"
    "maxsize 1400 1000, class:(com.usebottles.bottles)"

    # Animation for smooth appearance
    "animation slideIn, class:(com.usebottles.bottles)"

    # Optional: Make it slightly transparent
    "opacity 0.98, class:(com.usebottles.bottles)"
  ];
}
