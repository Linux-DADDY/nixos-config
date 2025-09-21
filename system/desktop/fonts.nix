{pkgs, ...}: {
  # Enable system-wide fonts
  fonts.packages = with pkgs; [
    # --- The System Foundation ---
    # For broad Unicode and web content support
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji

    # For language-specific support system-wide
    lohit-fonts.bengali

    # Good general-purpose fallbacks
    dejavu_fonts
    liberation_ttf
  ];
}
