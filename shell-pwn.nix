{
  pkgs ? import <nixpkgs> {},
  pwndbg,
  ...
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    clang
    libgcc
    pwndbg
    one_gadget
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        docker
        #angr
        ropper
        (callPackage (import ./pkgs/getlibs) {})
      ]))

    (ruby.withPackages (ruby-pkgs:
      with ruby-pkgs; [
        seccomp-tools
        timeout
      ]))

    radare2
    cutter

    aflplusplus
  ];

  inputsFrom = with pkgs; [libgcc pwndbg aflplusplus qemu unicorn gnumake];
}
