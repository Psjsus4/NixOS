{
  pkgs ? import <nixpkgs> {},
  pkgs-stable ? import <nixpkgs-stable> {},
  ...
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        pwndbg
        #pandas
        #requests
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        angr
      ]))
    radare2
  ];

  inputsFrom = with pkgs; [pwntools pwndbg radare2];

  shellHook = ''
    export NIX_LD="${pkgs.nix-ld}/bin/nix-ld"
  '';
}