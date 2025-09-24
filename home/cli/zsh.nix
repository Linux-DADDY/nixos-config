{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    # Enable auto-suggestions and syntax highlighting
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh with lightweight theme
    oh-my-zsh = {
      enable = true;
      theme = "random"; # Lightweight theme instead of random
      plugins = [
        "git"
        "sudo"
        "z"
        "copyfile"
        "copypath"
      ]; # Minimal plugins only
    };

    # Essential aliases
    shellAliases = {
      # Remap ls to lsd
      ls = "lsd";
      ll = "lsd -alF";
      la = "lsd -A";
      l = "lsd -CF";

      # Safety nets
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";

      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
    };

    # Performance optimized configuration
    initContent = ''
      # Disable compinit check for faster startup
      skip_global_compinit=1

      # Faster completion init
      autoload -Uz compinit
      if [[ -n ''${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
        compinit
      else
        compinit -C
      fi

      # Auto-suggestions - performance tuned
      ZSH_AUTOSUGGEST_MANUAL_REBIND=1
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"
      ZSH_AUTOSUGGEST_STRATEGY=(history)  # Only history, not completion (faster)
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      ZSH_AUTOSUGGEST_USE_ASYNC=1

      # Accept suggestions with right arrow
      bindkey '→' autosuggest-accept

      # Minimal completion settings for speed
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.zsh/cache

      # Performance options
      setopt NO_BEEP
      setopt HIST_VERIFY
      setopt SHARE_HISTORY
      setopt INC_APPEND_HISTORY
      setopt HIST_IGNORE_DUPS
      setopt HIST_FIND_NO_DUPS

      # Disable slow features
      DISABLE_UNTRACKED_FILES_DIRTY="true"
      DISABLE_AUTO_UPDATE="true"
    '';
  };

  # Minimal packages
  home.packages = with pkgs; [
    lsd
    zsh-autosuggestions
  ];
}
