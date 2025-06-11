{
  pkgs ? import <nixpkgs> {},
  pwndbg,
  ...
}: let
in
  pkgs.mkShell {
    packages = with pkgs; [
      libgcc
      #clisp
      rlwrap
      sbcl
      python3
      nodejs
      hexo-cli
      pwndbg

      (python3.withPackages (python-pkgs:
        with python-pkgs; [
          pwntools
          docker
        ]))
    ];

    inputsFrom = with pkgs; [libgcc qemu gnumake sbcl nodejs];
  }
