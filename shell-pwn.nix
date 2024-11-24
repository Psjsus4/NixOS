{
  pkgs ? import <nixpkgs> {},
  pkgs-stable ? import <nixpkgs-stable> {},
  ...
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    clang
    libgcc

    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        pwndbg
        docker
        ropper
        (callPackage (import ./pkgs/getlibs) {})
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        angr
      ]))

    (ruby_3_3.withPackages (ruby_3_3-pkgs:
      with ruby_3_3-pkgs; [
        seccomp-tools
      ]))

    radare2

    aflplusplus
  ];

  inputsFrom = with pkgs; [libgcc pwndbg aflplusplus qemu unicorn gnumake];
}
