{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Hyprland binds
      # Kill Active window. Whatever is front of you.
      "SUPER,C,killactive,"
      #"SUPERSHIFT,Q,exec,hyprctl dispatch exit"
      #"SUPERSHIFT,Q,exec,uwsm stop" NOTE: broken.
      "SUPERSHIFT,Q, exec, loginctl kill-session $XDG_SESSION_ID"

      # GameMode
      "SUPER,F1,exec, $GameMode"

      # lockScreen
      # "CTRLALT,l,exec, ~/.config/hypr/scripts/LockScreen"

      "CTRLALT,l,exec, hyprlock"

      # FLoat window
      "SUPER,F,fullscreen,"
      "SUPER,SPACE,togglefloating, active"

      # CycleNext
      #"SUPER,TAB,cyclenext,"
      #"SUPER,TAB,bringactivetotop,"

      # Screenlock
      "CTRLALT,L,exec,$screenlock"

      # ZOOM
      #"SUPER,grave,exec,pypr zoom"

      # Focus
      "SUPER,left,movefocus,l"
      "SUPER,right,movefocus,r"
      "SUPER,up,movefocus,u"
      "SUPER,down,movefocus,d"

      # Move
      "SUPERSHIFT,left,movewindow,l"
      "SUPERSHIFT,right,movewindow,r"
      "SUPERSHIFT,up,movewindow,u"
      "SUPERSHIFT,down,movewindow,d"

      # Resize
      "SUPERCTRL,left,resizeactive,-20 0"
      "SUPERCTRL,right,resizeactive,20 0"
      "SUPERCTRL,up,resizeactive,0 -20"
      "SUPERCTRL,down,resizeactive,0 20"

      # Workspaces
      "SUPER,1,workspace,1"
      "SUPER,2,workspace,2"
      "SUPER,3,workspace,3"
      "SUPER,4,workspace,4"
      "SUPER,5,workspace,5"
      "SUPER,6,workspace,6"
      "SUPER,7,workspace,7"
      "SUPER,8,workspace,8"
      "SUPER,9,workspace,9"
      # SUPER,0,workspace,0

      # Send to Workspaces
      "SUPERSHIFT,1,movetoworkspace,1"
      "SUPERSHIFT,2,movetoworkspace,2"
      "SUPERSHIFT,3,movetoworkspace,3"
      "SUPERSHIFT,4,movetoworkspace,4"
      "SUPERSHIFT,5,movetoworkspace,5"
      "SUPERSHIFT,6,movetoworkspace,6"
      "SUPERSHIFT,7,movetoworkspace,7"
      "SUPERSHIFT,8,movetoworkspace,8"
      "SUPERSHIFT,9,movetoworkspace,9"
      # ",0,movetoworkspace,0"

      #         # workspace -> split-workspace
      # "SUPER, 1, split-workspace, 1"
      # "SUPER, 2, split-workspace, 2"
      # "SUPER, 3, split-workspace, 3"
      # "SUPER, 4, split-workspace, 4"
      # "SUPER, 5, split-workspace, 5"
      # "SUPER, 6, split-workspace, 6"
      # "SUPER, 7, split-workspace, 7"
      # "SUPER, 8, split-workspace, 8"
      # "SUPER, 9, split-workspace, 9"
      # "SUPERSHIFT, H, workspace, -1"
      # "SUPERSHIFT, L, workspace, +1"
      # "SUPERCTRL, h, movetoworkspace, -1"
      # "SUPERCTRL, l, movetoworkspace, +1"
      # "SUPERSHIFT_CTRL, h, movetoworkspacesilent, -1"
      # "SUPERSHIFT_CTRL, l, movetoworkspacesilent, +1"
      # # bind = SUPER, TAB, exec, hyprctl dispatch workspace $(hyprctl -j monitors | jaq -r '.[] | select(.focused == true) | .activeWorkspace.id')
      # # movetoworkspace -> split-movetoworkspace
      # "SUPERSHIFT, 1, split-movetoworkspace, 1"
      # "SUPERSHIFT, 2, split-movetoworkspace, 2"
      # "SUPERSHIFT, 3, split-movetoworkspace, 3"
      # "SUPERSHIFT, 4, split-movetoworkspace, 4"
      # "SUPERSHIFT, 5, split-movetoworkspace, 5"
      # "SUPERSHIFT, 6, split-movetoworkspace, 6"
      # "SUPERSHIFT, 7, split-movetoworkspace, 7"
      # "SUPERSHIFT, 8, split-movetoworkspace, 8"
      # "SUPERSHIFT, 9, split-movetoworkspace, 9"
      # "SUPERSHIFT, 0, split-movetoworkspace, 10"
      # # movetoworkspacesilent -> split-movetoworkspacesilent
      # "SUPERSHIFT_CTRL, 1, split-movetoworkspacesilent, 1"
      # "SUPERSHIFT_CTRL, 2, split-movetoworkspacesilent, 2"
      # "SUPERSHIFT_CTRL, 3, split-movetoworkspacesilent, 3"
      # "SUPERSHIFT_CTRL, 4, split-movetoworkspacesilent, 4"
      # "SUPERSHIFT_CTRL, 5, split-movetoworkspacesilent, 5"
      # "SUPERSHIFT_CTRL, 6, split-movetoworkspacesilent, 6"
      # "SUPERSHIFT_CTRL, 7, split-movetoworkspacesilent, 7"
      # "SUPERSHIFT_CTRL, 8, split-movetoworkspacesilent, 8"
      # "SUPERSHIFT_CTRL, 9, split-movetoworkspacesilent, 9"
      # "SUPERSHIFT_CTRL, 0, split-movetoworkspacesilent, 10"

      # Scroll through existing workspaces with mainMod + scroll
      "SUPER,mouse_down,workspace,e+1"
      "SUPER,mouse_up,workspace,e-1"

      # -- Rofi --
      # "SUPER,D,exec,$launcher"
      "SUPER,D,exec,sh ~/.config/hypr/rofi/bin/launcher"
      "SUPERSHIFT,C,exec,sh ~/.config/hypr/rofi/bin/clipboard"
      "SUPER,X,exec,sh ~/.config/hypr/rofi/bin/powermenu"
      "SUPER,S,exec,sh ~/.config/hypr/rofi/bin/screenshot"

      #FIXME:, Have to fix those.
      # "SUPERSHIFT,C,exec,$clipboard"
      # "SUPER,X,exec,$powermenu"
      # "SUPER,S,exec,$screenshot"

      # Waybar
      # "SUPER, B, exec, pkill -SIGUSR1 waybar"
      # "SUPERSHIFT, B, exec, pkill -SIGUSR1 waybar && $GameMode"

      # -- Apps --
      "SUPERSHIFT,F,exec,nemo"
      "SUPERSHIFT,W,exec,vivaldi"
      # "SUPERSHIFT,E,exec,geany"
      # -- Terminal --
      # bind=SUPER,RETURN,exec,$term
      # SUPERSHIFT,RETURN,exec,$term -f
      # SUPER,RETURN,exec,$term
      "SUPER,RETURN,exec,kitty"
      # "SUPERSHIFT,RETURN,exec,$term -f"
      #"SUPERSHIFT,RETURN,exec, kitty --class=kitty-float"
      "SUPER,RETURN,exec,$term"
      # bind=SUPER,RETURN,exec,alacritty
    ];
    exec-once = [
      # "easyeffects --gapplication-service" # Starts easyeffects in the background
      # "importGsettings"
      # "zen"
      # "vivaldi"
      "wpaperd"
      # "beeper"
      # "appimage-run AppImages/beeper.appimage --ozone-platform-hint=auto --enable-wayland-ime --enable-features=TouchpadOverscrollHistoryNavigation --wayland-text-input-version=3" #NOTE: This this for running appimage of the beeper on startup.
      # "okular"
      # "discord"
      # "rambox"
      # "appimage-run AppImages/rambox.appimage" #BUG: "Have gpu/cpu issue which cause lag" #NOTE; This is for runnning the appimage of the rambox on startup.
      "nemo"
      # "~/.config/hypr/scripts/StatusBar"
      # "virt-manager"
      # "fcitx5 -d"
      "hyprshade on vibrance" #FIXME:, For some reason this dosn't work with the hyprshade install.
      "pypr"
      #"nwg-dock-hyprland -d"
      # "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE"

      "swww-daemon --format xrgb"

      # System
      # "systemctl --user import-environment &"
      # "hash dbus-update-activation-environment 2>/dev/null &"
      # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
      "dbus-update-activation-environment --systemd --all"
      # "poweralertd &"
      # "systemctl --user start hyprpolkitagent&"
      # "${pkgs.hyprpanel}/bin/hyprpanel"
      "hyprpanel"
      "fcitx5 -d # not ${pkgs.fcitx5}/bin/fcitx5 !"
    ];
    # Mouse binds
    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];
    bindl = [
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"

      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"

      # ", XF86AudioLowerVolume, exec, $volume --inc"
      # ", XF86AudioRaiseVolume, exec, $volume --dec"

      # ", XF86MonBrightnessUp,  exec, brightnessctl s +5%"
      # ", XF86MonBrightnessDown,  exec, brightnessctl s 5%-"

      # ", XF86MonBrightnessUp,  exec, $backlight --inc "
      # ", XF86MonBrightnessDown,  exec, $backlight --dec "

      ", XF86MonBrightnessUp, exec, brightnessctl set 10+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10-"
      "SUPER, F11, exec, brightnessctl set 5%-"
      "SUPER, F12, exec, brightnessctl set +5%"
    ];
  };
}
