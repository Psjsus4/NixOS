{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    zsh
    fzf
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      bindkey "^[[1;3C" forward-word                  # Key Alt + Right
      bindkey "^[[1;3D" backward-word                 # Key Alt + Left
      bindkey "^H" backward-kill-word                 # Key Ctrl + H

      eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config ${./zen.toml})"

      dev() {
        if [[ "$1" == "clear" ]]; then
            if [[ -n "$IN_NIX_SHELL" && -n "$DIRENV_DIR" ]]; then
                direnv_dir=$(printf '%s' "$DIRENV_DIR" | sed 's/^-//')
                rm -rf $direnv_dir/.direnv
                echo "" > $direnv_dir/.envrc
                direnv deny
            else
                echo "\033[0;31mnot in direnv"
                return 1
            fi
        else
            if [[ $# -gt 0 ]]; then
                shift
                if [[ -n "$1" ]]; then
                    echo "use flake $FLAKE#$1" > .envrc
                else
                    echo "use flake $FLAKE" > .envrc
                fi
            else
                echo "use flake $FLAKE" > .envrc
            fi
            direnv allow
        fi
      }


      if command -v nix-your-shell > /dev/null; then
        nix-your-shell zsh | source /dev/stdin
      fi

      nix() {
        if [[ "$1" == "dev" ]]; then
          shift
          if [[ -n "$1" ]]; then
              # Use the first argument with nix develop
              nix-your-shell  zsh nix develop $FLAKE#$1
          else
              nix-your-shell  zsh nix develop $FLAKE
          fi
        else
          command nix-your-shell  zsh nix $@
        fi
      }

    '';

    shellAliases = {
      cat = "bat";
      cd = "z";
      cdi = "zi";
      vi = "nvim";
      vim = "nvim";
      ls = "eza --icons";
      tree = "eza --tree --icons";
      pwninit = "pwninit --template-path $FLAKE/home-manager/pwninit/pwninit-tmpt.py --template-bin-name e";
      gdb = "pwndbg";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
  };
}
