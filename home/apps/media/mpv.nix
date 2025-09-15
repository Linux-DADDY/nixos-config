{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
      deinterlace = "auto";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dither-depth = "auto";
      save-position-on-quit = false;
      video-sync = "display-resample";
      # volume-max = 100;
      # cache-default = 4000000; #NOTE: HAD problem with this one.
    };
    scripts = with pkgs; [
      mpvScripts.mpris
    ];
    scriptOpts = {
      osc = {
        scalewindowed = 2.0;
        vidscale = false;
        # visibility = "always"; #NOTE: bar will be always visible which is a bad thing.
      };
    };
  };
}
