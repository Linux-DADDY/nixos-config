{pkgs, ...}: let
  Cartograph = pkgs.stdenv.mkDerivation {
    pname = "Cartograph-CF";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "g5becks";
      repo = "Cartograph";
      rev = "main";
      sha256 = "sha256-P8cii7ez9bAE+c7tN+oWQy3/LQPFtGUmlwQsKevbl0M=";
    };

    installPhase = ''
      mkdir -p $out/share/fonts/truetype

      # Copy all font files
      find . -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;
      find . -name "*.otf" -exec cp {} $out/share/fonts/truetype/ \;

      # Optional: Copy specific directories if fonts are in subdirectories
      if [ -d "fonts" ]; then
        cp fonts/*.ttf $out/share/fonts/truetype/ 2>/dev/null || true
        cp fonts/*.otf $out/share/fonts/truetype/ 2>/dev/null || true
      fi
    '';
  };
in {
  home.packages = [Cartograph];
  fonts.fontconfig.enable = true;
}
