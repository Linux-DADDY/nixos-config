{
  config,
  pkgs,
  ...
}: {
  # Enable XDG mime apps
  xdg = {
    #enable = true;

    # Set default applications for MIME types
    mimeApps = {
      enable = true;
      defaultApplications = {
        # Images
        "image/jpeg" = ["viewnior.desktop"];
        "image/png" = ["viewnior.desktop"];
        "image/gif" = ["viewnior.desktop"];
        "image/svg+xml" = ["viewnior.desktop"];
        "image/webp" = ["viewnior.desktop"];
        "image/tiff" = ["viewnior.desktop"];
        "image/bmp" = ["viewnior.desktop"];
        "image/x-icon" = ["viewnior.desktop"];
        "image/vnd.microsoft.icon" = ["viewnior.desktop"];

        # Videos
        "video/mp4" = ["mpv.desktop"];
        "video/x-matroska" = ["mpv.desktop"];
        "video/webm" = ["mpv.desktop"];
        "video/avi" = ["mpv.desktop"];
        "video/quicktime" = ["mpv.desktop"];
        "video/x-msvideo" = ["mpv.desktop"];
        "video/x-flv" = ["mpv.desktop"];
        "video/x-ms-wmv" = ["mpv.desktop"];
        "video/mpeg" = ["mpv.desktop"];
        "video/3gpp" = ["mpv.desktop"];

        # Audio (also using mpv)
        "audio/mpeg" = ["mpv.desktop"];
        "audio/mp3" = ["mpv.desktop"];
        "audio/mp4" = ["mpv.desktop"];
        "audio/flac" = ["mpv.desktop"];
        "audio/ogg" = ["mpv.desktop"];
        "audio/wav" = ["mpv.desktop"];
        "audio/x-wav" = ["mpv.desktop"];
        "audio/webm" = ["mpv.desktop"];

        # Web/Browser - CORRECTED TO zen-beta.desktop
        "text/html" = ["zen-beta.desktop"];
        "application/xhtml+xml" = ["zen-beta.desktop"];
        "application/xml" = ["zen-beta.desktop"];
        "x-scheme-handler/http" = ["zen-beta.desktop"];
        "x-scheme-handler/https" = ["zen-beta.desktop"];
        "x-scheme-handler/ftp" = ["zen-beta.desktop"];
        "x-scheme-handler/about" = ["zen-beta.desktop"];
        "x-scheme-handler/unknown" = ["zen-beta.desktop"];

        # Text/Editor
        "text/plain" = ["nvim.desktop"];
        "text/x-python" = ["nvim.desktop"];
        "text/x-c" = ["nvim.desktop"];
        "text/x-c++" = ["nvim.desktop"];
        "text/x-java" = ["nvim.desktop"];
        "text/x-shellscript" = ["nvim.desktop"];
        "text/x-script.python" = ["nvim.desktop"];
        "text/markdown" = ["nvim.desktop"];
        "text/x-makefile" = ["nvim.desktop"];
        "text/x-readme" = ["nvim.desktop"];
        "application/x-yaml" = ["nvim.desktop"];
        "application/json" = ["nvim.desktop"];
        "application/javascript" = ["nvim.desktop"];

        # PDFs - Okular as viewer
        "application/pdf" = ["okular.desktop"];

        # Archives - File Roller for Nemo
        "application/zip" = ["file-roller.desktop"];
        "application/x-tar" = ["file-roller.desktop"];
        "application/x-compressed-tar" = ["file-roller.desktop"];
        "application/x-7z-compressed" = ["file-roller.desktop"];
        "application/x-rar" = ["file-roller.desktop"];
        "application/x-gzip" = ["file-roller.desktop"];
        "application/x-bzip2" = ["file-roller.desktop"];
        "application/x-xz" = ["file-roller.desktop"];

        # Terminal
        "application/x-terminal-emulator" = ["kitty.desktop"];

        # Directories (file manager - Nemo)
        "inode/directory" = ["nemo.desktop"];
      };
    };
  };

  # Create desktop entries if they don't exist
  xdg.desktopEntries = {
    # Neovim desktop entry (if not already present)
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      exec = "kitty nvim %F";
      terminal = false;
      categories = ["Development" "IDE" "TextEditor"];
      mimeType = [
        "text/plain"
        "text/x-python"
        "text/x-c"
        "text/x-c++"
        "text/x-java"
        "text/x-shellscript"
        "text/markdown"
        "application/x-yaml"
        "application/json"
      ];
    };
  };
}
