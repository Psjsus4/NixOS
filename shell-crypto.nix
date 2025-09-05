{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        pycryptodome
        gmpy2
        #pandas
        #requests
      ]))
    sage
    #john
    crunch
  ];
}
