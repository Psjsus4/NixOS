{
  pkgs ? import <nixpkgs> {},
  pwndbg,
  ...
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    clang
    libgcc
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        docker
        ropper
        pwndbg
        (callPackage (import ./pkgs/getlibs) {})
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
