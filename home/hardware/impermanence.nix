{declarative, ...}: {
  home.persistence."/persist/home/${declarative.username}" = {
    allowOther = true;
    removePrefixDirectory = true; # ← CRITICAL: Only mount specific directories

    directories = [
      # Standard user directories
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Desktop"
      "Public"
      "Templates"

      # Security
      ".gnupg"
      ".local/share/keyrings"

      # Development & Config
      ".config/git"

      # Browsers
      ".zen"
      ".cache/zen"

      # Media
      #".config/mpv"
      #".local/share/vlc"

      # System
      #".local/state/wireplumber"
      #".config/pulse"

      # Shell
      #".bash_history"

      # Desktop & Apps
      ".local/share/applications"
      ".local/share/icons"
      ".config/fontconfig"

      # Your custom game/mod dirs
      "Games"
      "Game-Mods"
      "Appimages"
    ];

    files = [
      #".bashrc"
      #".profile"
      #".bash_history"
      #".config/mimeapps.list"
      #".config/user-dirs.dirs"
      #".config/user-dirs.locale"
    ];
  };
}
