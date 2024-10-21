{
  pkgs,
  lib,
  config,
  ...
}:
{
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
	pwninit = "pwninit --template-path ~/.config/pwninit-tmpt.py --template-bin-name e";
        };
    };
}
