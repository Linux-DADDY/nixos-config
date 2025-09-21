{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;

    settings = {
      # Font configuration
      font = {
        normal = {
          family = "MonoLisa SemiBold";
          style = "SemiBold";
        };
        italic = {
          family = "MonoLisa SemiBold Italic";
          style = "Italic";
        };
        bold = {
          family = "MonoLisa ExtraBold";
          style = "ExtraBold";
        };
        bold_italic = {
          family = "MonoLisa ExtraBold Italic";
          style = "ExtraBold Italic";
        };
        size = 18;
      };

      # Window configuration
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "buttonless"; # Equivalent to Kitty's "Buttonless"
        opacity = 1.0; # Alacritty doesn't support background blur like Kitty
        dynamic_padding = false;
      };

      # Cursor configuration
      cursor = {
        style = "Beam"; # Equivalent to Kitty's "beam"
        blink_interval = 0; # -1 in Kitty means no blinking, 0 in Alacritty means no blinking
        blink_timeout = 15; # Equivalent to cursor_stop_blinking_after
        unfocused_hollow = true;
        thickness = 1.0; # Equivalent to cursor_beam_thickness
      };

      # Scrolling
      scrolling = {
        history = 10000; # Equivalent to scrollback_lines
        multiplier = 3;
      };

      # Bell
      bell = {
        animation = "None";
        duration = 0;
        color = "#ffffff";
      };

      # Mouse
      mouse = {
        hide_when_typing = true; # Similar to mouse_hide_wait
      };

      # Selection
      selection = {
        save_to_clipboard = true;
      };

      # Terminal
      env = {
        TERM = "xterm-256color";
      };

      # Colors - Using Catppuccin Mocha theme equivalent
      # You would need to define the full color scheme here
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
      };

      # Key bindings
      key_bindings = [
        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "T";
          mods = "Control";
          action = "CreateNewTab";
        }
        {
          key = "W";
          mods = "Control";
          action = "CloseTab";
        }
        {
          key = "Key1";
          mods = "Alt";
          action = "GoToTab";
          value = 1;
        }
        {
          key = "Key2";
          mods = "Alt";
          action = "GoToTab";
          value = 2;
        }
        {
          key = "Key3";
          mods = "Alt";
          action = "GoToTab";
          value = 3;
        }
        {
          key = "Key4";
          mods = "Alt";
          action = "GoToTab";
          value = 4;
        }
        {
          key = "Key5";
          mods = "Alt";
          action = "GoToTab";
          value = 5;
        }
        {
          key = "Key6";
          mods = "Alt";
          action = "GoToTab";
          value = 6;
        }
        {
          key = "Key7";
          mods = "Alt";
          action = "GoToTab";
          value = 7;
        }
        {
          key = "Key8";
          mods = "Alt";
          action = "GoToTab";
          value = 8;
        }
        {
          key = "Key9";
          mods = "Alt";
          action = "GoToTab";
          value = 9;
        }
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
      ];
    };
  };
}
