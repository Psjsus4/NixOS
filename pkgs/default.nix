{pkgs ? import <nixpkgs> {}, ...}: {
  # example = pkgs.callPackage ./example { };
  getlibs = pkgs.python3Packages.callPackage ./getlibs {};
}
