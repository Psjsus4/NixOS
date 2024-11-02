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
      nix() {
        if [[ "$1" == "dev" ]]; then
          shift
          if [[ -n "$1" ]]; then
            nix develop "$FLAKE#$1"
          else
            nix develop "$FLAKE"
          fi
        else
          command nix "$@"
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
      nix-shell = "nix-shell --command zsh";
      pwninit = "pwninit --template-path $FLAKE/home-manager/pwninit/pwninit-tmpt.py --template-bin-name e";
      gdb = "pwndbg";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
  };
}
