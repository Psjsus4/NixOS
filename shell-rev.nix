{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    clang
    gcc
    glibc.dev
    openssl.dev
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        gef
        (callPackage (import ./pkgs/getlibs) {})
        #pandas
        #requests
      ]))
    cutter
    radare2
  ];

  inputsFrom = with pkgs; [glibc gef openssl];
}
