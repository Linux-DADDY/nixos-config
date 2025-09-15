{pkgs, ...}: let
  Firicico = pkgs.stdenv.mkDerivation {
    pname = "monolisa-github";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "Linux-DADDY";
      repo = "Firicico";
      rev = "master";
      sha256 = "sha256-tF9e6N0uNIuyo8MJ9HiGS0X6+IhFP2++2ND/Tv+t0e0=";
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
  home.packages = [Firicico];
  fonts.fontconfig.enable = true;
}
