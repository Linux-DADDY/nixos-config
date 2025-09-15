{pkgs, ...}: {
  home.packages = with pkgs; [
    pyprland
  ];
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "magnify",
      "shift_monitors",
      "workspaces_follow_focus",
      "layout_center",
      "scratchpads",
      "wallpapers",
    ]
    [scratchpads.term]
      animation = "fromTop"
      command = "kitty --class kitty-dropterm"
      class = "kitty-dropterm"
      size = "75% 60%"
      max_size = "1920px 100%"
      margin = 50
    [scratchpads.monitor]
      animation = "fromRight"
      command = "missioncenter"
      class = "io.missioncenter.MissionCenter"
      size = "55% 47%"
      unfocus = "hide"
      lazy = true
      margin = 15
    [scratchpads.filemanager]
      animation = "fromBottom"
      command = "nemo"
      class = "nemo"
      size = "60% 60%"
      skip_windowrules = ["aspect", "workspace"]
      lazy = true

    [wallpapers]
      unique = true # set a different wallpaper for each screen
      path = "~/Pictures/walls/"
      interval = 1 # change every hour
      extensions = ["jpg", "jpeg"]
      recurse = true
      ## Using swww
      command = 'swww img --transition-type fade "[file]"'
      clear_command = "swww clear"

  '';
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER,equal,exec,pypr zoom ++0.5"
      "SUPER,minus,exec,pypr zoom --0.5"
      "SUPER,0,exec,pypr zoom"
      "SUPER,TAB,exec,pypr zoom"

      "SUPER,grave,exec, pypr layout_center toggle # toggle the layout"
      "ALTSHIFT,1,exec, pypr layout_center next"
      "ALTSHIFT,2,exec, pypr layout_center prev"

      "SUPERSHIFT,RETURN,exec, pypr toggle term"
      "SUPER,M,exec, pypr toggle monitor"
      "SUPER,N,exec, pypr toggle filemanager"
    ];
  };
}
