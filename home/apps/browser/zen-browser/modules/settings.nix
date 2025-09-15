{config, ...}: {
  # Add these settings to your zen-settings.nix file
  programs.zen-browser.profiles.default = {
    settings = {
      # Enable Home button in toolbar
      #"browser.toolbars.bookmarks.visibility" = "always";
      #"browser.startup.homepage" = "https://pivoshenko.github.io/catppuccin-startpage/";

      # Theme - Auto/Light theme preference
      "ui.systemUsesDarkTheme" = 1; # Force dark theme detection
      "browser.theme.content-theme" = 0; # 0 for dark
      "browser.theme.toolbar-theme" = 0; # 0 for dark

      # Website appearance - Auto color scheme (follows system)
      # "layout.css.prefers-color-scheme.content-override" = 2; # 0 = dark, 1 = light, 2 = auto

      # Always ask where to save files
      "browser.download.useDownloadDir" = false;
      # Optional: Set default download directory (though it will still ask)
      "browser.download.dir" = "${config.home.homeDirectory}/Downloads";

      # Enable autoscrolling (middle mouse button scrolling)
      "general.autoScroll" = true;

      # Additional autoscroll settings
      "general.smoothScroll" = true; # Smooth scrolling
      "mousewheel.default.delta_multiplier_y" = 100; # Scroll speed multiplier

      # Your existing settings...
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      #"browser.startup.homepage" = "https://pivoshenko.github.io/catppuccin-startpage/";
      "browser.search.defaultenginename" = "ecosia";
      "browser.search.order.1" = "ecosia";
      "browser.tabs.warnOnClose" = false;
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_pbm" = true;
    };
  };
}
