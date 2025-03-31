{pkgs ? import <nixpkgs> {}, ...}: let
  # Create a custom Python environment with unicorn-angr override
  customPython = pkgs.python3.override {
    packageOverrides = self: super: {
      # Replace standard unicorn with unicorn-angr
      unicorn = super.unicorn-angr;
    };
  };
in
  pkgs.mkShell {
    packages = with pkgs; [
      gcc
      glibc.dev
      openssl.dev
      (customPython.withPackages (python-pkgs:
        with python-pkgs; [
          pwntools
          gef
          angr
          (callPackage (import ./pkgs/getlibs) {})
          #pandas
          #requests
        ]))
      cutter
      radare2
    ];

    inputsFrom = with pkgs; [glibc openssl];
  }
