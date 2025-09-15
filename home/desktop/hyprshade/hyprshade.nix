{
  config,
  pkgs,
  ...
}: {
  # Install hyprshade
  home.packages = with pkgs; [
    hyprshade
  ];

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Add keybindings for hyprshade
      bind = [
        "SUPER, F9, exec, hyprshade toggle"
        "SUPER, F10, exec, hyprshade toggle blue-light-filter"
      ];

      # Auto-start hyprshade
      exec-once = [
        "hyprshade auto"
      ];
    };
  };

  # Hyprshade configuration files
  xdg.configFile."hyprshade/config.toml".text = ''
    [[shades]]
    name = "vibrance"
    default = true  # will be activated when no other shader is scheduled
  '';

  # Add shader files
  xdg.configFile."hyprshade/shaders" = {
    source = ./shaders; # You can also point to a directory with your shaders
    recursive = true;
  };
}
