{
  pkgs ? import <nixpkgs> {},
  pwndbg,
  avrPkgs,
  ...
}: let
in
  avrPkgs.mkShell {
    packages = with pkgs; [
      libgcc
      python3
      pwndbg
      arduino
      arduino-cli
      avrdude

      (python3.withPackages (python-pkgs:
        with python-pkgs; [
          pwntools
          docker
        ]))
    ];
  }
