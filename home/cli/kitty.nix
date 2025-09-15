{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font.name = "FantasqueSansM Nerd Font Mono Italic";
    font.size = 18;
    themeFile = "Catppuccin-Mocha";
    keybindings = {
      "ctrl+equal" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+0" = "change_font_size all 0"; # Reset to default size

      "ctrl+t" = "new_tab";
      "ctrl+w" = "close_tab";
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";

      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    settings = {
      cursor_shape = "beam";
      cursor_beam_thickness = 1;
      cursor_underline_thickness = 2;
      cursor_blink_interval = -1;
      cursor_stop_blinking_after = 15;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      mouse_hide_wait = 3;
      sync_to_monitor = true;
      window_padding_width = 10;

      # Font configuration
      #Ficicico
      #      font_family = "Firicico";
      #Comic Code
      #font_family = "Comic Code Ligatures SemiBold Italic";
      font_family = "MonoLisa SemiBold";
      italic_font = "MonoLisa SemiBold Italic";
      bold_font = "MonoLisa ExtraBold";
      bold_italic_font = "MonoLisa ExtraBold Italic";

      # Font rendering
      disable_ligatures = "never";
      font_features = "MonoLisa +cv02 +cv14"; # Optional: enable stylistic sets

      background_blur = 1; # Set to a positive value to enable background blur
      #      background_image = "/etc/nixos/Wallpapers/a_person_sitting_on_a_horse_next_to_a_lamp_post.png";
      #      background_image_layout = "scaled"; # or "mirrored", "scaled", "clamped", "centered"
      #      background_image_linear = false; # Use linear interpolation
      # background_tint = "0.0"; # Darken image (0.0-1.0)
      dynamic_background_opacity = true;
    };
  };
}
