{
  pkgs ? import <nixpkgs> {},
  pkgs-stable ? import <nixpkgs-stable> {},
  ...
}:
pkgs.mkShell {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        # select Python packages here
        pwntools
        pwndbg
        #pandas
        #requests
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        # select Python packages hereexport NIX_LD="${pkgs.nix-ld}/bin/nix-ld"
        angr
        #pandas
        #requests
      ]))
    radare2
  ];

  inputsFrom = with pkgs; [pwntools pwndbg radare2];

  shellHook = ''
    exec zsh
  '';
}
