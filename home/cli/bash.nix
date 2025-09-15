{
  config,
  pkgs,
  ...
}: {
  # Enable Bash as your shell
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "lsd -alF";
      la = "lsd -A";
      l = "lsd -F";
      ls = "lsd";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };

    bashrcExtra = ''
      # Catppuccin Mocha colors for prompt
      setup_prompt() {
        local reset='\[\033[0m\]'
        local bold='\[\033[1m\]'

        # Catppuccin colors in ANSI
        local mauve='\[\033[38;2;203;166;247m\]'
        local green='\[\033[38;2;166;227;161m\]'
        local teal='\[\033[38;2;148;226;213m\]'
        local blue='\[\033[38;2;137;180;250m\]'
        local yellow='\[\033[38;2;249;226;175m\]'
        local peach='\[\033[38;2;250;179;135m\]'
        local red='\[\033[38;2;243;139;168m\]'
        local text='\[\033[38;2;205;214;244m\]'
        local subtext1='\[\033[38;2;186;194;222m\]'
        local surface2='\[\033[38;2;88;91;112m\]'

        # Git branch function
        git_branch() {
          git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
        }

        # Set the prompt
        PS1="''${bold}''${mauve}\u''${reset}''${surface2}@''${reset}''${blue}\h''${reset} ''${green}\w''${reset} ''${yellow}\$(git_branch)''${reset}\n''${teal}❯''${reset} "
        PS2="''${teal}❯''${reset} "
      }

      setup_prompt

      # mkcd - make directory and cd into it
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      # copyfile - copies file contents to clipboard
      copyfile() {
        if [[ $# -eq 0 ]]; then
          echo "Usage: copyfile <filename>"
          return 1
        fi

        if [[ ! -f "$1" ]]; then
          echo "Error: '$1' is not a valid file"
          return 1
        fi

        local clip_cmd=""

        if [[ -n "$WAYLAND_DISPLAY" ]] && command -v wl-copy &> /dev/null; then
          clip_cmd="wl-copy"
        elif command -v xclip &> /dev/null; then
          clip_cmd="xclip -selection clipboard"
        elif command -v xsel &> /dev/null; then
          clip_cmd="xsel --clipboard --input"
        else
          echo "Error: No clipboard utility found. Please install xclip or wl-clipboard"
          return 1
        fi

        if cat "$1" | $clip_cmd; then
          echo "✓ Contents of '$1' copied to clipboard"
        else
          echo "✗ Failed to copy '$1' to clipboard"
          return 1
        fi
      }

      # copypath - copies file's full path to clipboard
      copypath() {
        local file_path

        if [[ $# -eq 0 ]]; then
          file_path="$(pwd)"
        else
          file_path="$(realpath "$1" 2>/dev/null)"
          if [[ $? -ne 0 ]]; then
            echo "Error: '$1' does not exist"
            return 1
          fi
        fi

        local clip_cmd=""

        if [[ -n "$WAYLAND_DISPLAY" ]] && command -v wl-copy &> /dev/null; then
          clip_cmd="wl-copy"
        elif command -v xclip &> /dev/null; then
          clip_cmd="xclip -selection clipboard"
        elif command -v xsel &> /dev/null; then
          clip_cmd="xsel --clipboard --input"
        else
          echo "Error: No clipboard utility found. Please install xclip or wl-clipboard"
          return 1
        fi

        if echo -n "$file_path" | $clip_cmd; then
          echo "✓ Path copied to clipboard: $file_path"
        else
          echo "✗ Failed to copy path to clipboard"
          return 1
        fi
      }

      # extract - extract various archive formats
      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.tar.xz)    tar xJf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.deb)       ar x "$1"        ;;
            *.tar.zst)   tar xf "$1"      ;;
            *)           echo "'$1' cannot be extracted" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }

      # Source blesh for auto-suggestions
      if [[ -f ${pkgs.blesh}/share/blesh/ble.sh ]]; then
        source ${pkgs.blesh}/share/blesh/ble.sh --attach=none

        # Configure blesh settings
        bleopt complete_auto_delay=300
        bleopt complete_auto_history=1
        bleopt complete_ambiguous=1
        bleopt complete_menu_filter=1
        bleopt complete_menu_style=align-nowrap

        # Catppuccin theme for blesh - All faces corrected
        # Region and editing faces
        ble-face region='bg=59,65,79'
        ble-face region_insert='bg=166,227,161,fg=17,17,27'
        ble-face disabled='fg=108,112,134'
        ble-face overwrite_mode='bg=249,226,175,fg=17,17,27'
        ble-face auto_complete='fg=108,112,134'

        # Syntax highlighting faces
        ble-face syntax_default='fg=205,214,244'
        ble-face syntax_command='fg=137,180,250'
        ble-face syntax_function_name='fg=137,180,250'
        ble-face syntax_comment='fg=108,112,134,italic'
        ble-face syntax_glob='fg=243,139,168'
        ble-face syntax_brace='fg=243,139,168'
        ble-face syntax_param_expansion='fg=249,226,175'
        ble-face syntax_history_expansion='fg=250,179,135'
        ble-face syntax_expr='fg=250,179,135'
        ble-face syntax_quoted='fg=166,227,161'
        ble-face syntax_quotation='fg=166,227,161,bold'
        ble-face syntax_escape='fg=245,194,231'
        ble-face syntax_error='bg=243,139,168,fg=17,17,27'
        ble-face syntax_varname='fg=180,190,254'
        ble-face syntax_delimiter='fg=186,194,222,bold'
        ble-face syntax_tilde='fg=148,226,213'

        # Command type faces
        ble-face command_builtin='fg=137,180,250,bold'
        ble-face command_builtin_dot='fg=243,139,168,bold'
        ble-face command_alias='fg=203,166,247'
        ble-face command_function='fg=137,180,250'
        ble-face command_file='fg=205,214,244'
        ble-face command_keyword='fg=203,166,247'
        ble-face command_directory='fg=137,180,250,underline'

        # Filename faces
        ble-face filename_directory='fg=137,180,250,bold'
        ble-face filename_executable='fg=166,227,161,bold'
        ble-face filename_link='fg=148,226,213'
        ble-face filename_orphan='fg=243,139,168,bg=59,65,79'
        ble-face filename_block='fg=249,226,175'
        ble-face filename_character='fg=249,226,175'
        ble-face filename_pipe='fg=245,194,231'
        ble-face filename_socket='fg=245,194,231'
        ble-face filename_setuid='fg=17,17,27,bg=243,139,168'
        ble-face filename_setgid='fg=17,17,27,bg=249,226,175'
        # Fixed: Removed non-existent faces
        ble-face filename_directory_sticky='fg=166,227,161,bg=59,65,79'
        ble-face filename_warning='fg=249,226,175'

        # Variable type faces
        ble-face varname_array='fg=250,179,135'
        ble-face varname_empty='fg=108,112,134'
        ble-face varname_export='fg=166,227,161'
        ble-face varname_expr='fg=250,179,135'
        ble-face varname_hash='fg=148,226,213'
        ble-face varname_number='fg=250,179,135'
        ble-face varname_readonly='fg=243,139,168'
        ble-face varname_transform='fg=249,226,175'
        ble-face varname_unset='fg=108,112,134'

        # Argument faces
        ble-face argument_option='fg=245,194,231,italic'
        ble-face argument_error='bg=243,139,168,fg=17,17,27'

        # Correct blesh key bindings
        ble-bind -f 'C-l' 'clear-screen'
        ble-bind -f 'C-w' 'kill-backward-uword'
        ble-bind -f 'M-d' 'kill-uword'
        ble-bind -f 'C-k' 'kill-forward-line'
        ble-bind -f 'C-u' 'kill-backward-line'
        ble-bind -f 'M-f' 'forward-uword'
        ble-bind -f 'M-b' 'backward-uword'

        # Attach blesh
        [[ ''${BLE_VERSION-} ]] && ble-attach
      fi
    '';

    initExtra = ''
      # History settings
      shopt -s histappend
      shopt -s checkwinsize
      shopt -s globstar
      shopt -s nocaseglob
      shopt -s cdspell

      HISTSIZE=10000
      HISTFILESIZE=20000
      HISTCONTROL="ignoreboth:erasedups"
      HISTTIMEFORMAT="%F %T "
      HISTIGNORE="ls:ll:la:cd:pwd:exit:clear:history"

      # Better directory navigation
      shopt -s autocd
      shopt -s dirspell
      shopt -s cdable_vars

      # Disable XON/XOFF flow control
      stty -ixon 2>/dev/null || true

      # Set LS_COLORS with Catppuccin theme
      export LS_COLORS="di=1;34:ln=36:so=35:pi=33:ex=1;32:bd=33;1:cd=33;1:su=37;41:sg=30;43:tw=30;42:ow=34;42"

      # Set default editor
      export EDITOR="''${EDITOR:-vim}"
      export VISUAL="''${VISUAL:-$EDITOR}"

      # Better less defaults
      export LESS="-R -F -X"
      export LESSHISTFILE=-
    '';
  };

  # Enable fzf with Catppuccin theme
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border=rounded"
      "--prompt='❯ '"
      "--pointer='▶'"
      "--marker='✓'"
      "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8"
      "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
      "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    ];
  };

  # Install packages for NixOS
  home.packages = with pkgs; [
    blesh
    ripgrep
    fd
    tree
    lsd # Added lsd
    eza
    zoxide
    tldr
    jq
    yq
    htop
    ncdu

    # Clipboard utilities for Linux
    xclip
    wl-clipboard
  ];
}
