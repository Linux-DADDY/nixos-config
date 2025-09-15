{pkgs, ...}: let
  Comic-Code = pkgs.stdenv.mkDerivation {
    pname = "Comic-Code";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "Linux-DADDY";
      repo = "Comic-Code";
      rev = "main";
      sha256 = "sha256-tmik1vJi5RtlX+BIzSNS8Xobhk/66GNdw3NdxfjC4tg=";
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
  home.packages = [Comic-Code];
  fonts.fontconfig.enable = true;
}
