{
  pkgs ? import <nixpkgs> {},
  pwndbg,
  ...
}: let
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
      qemu

      libgcc
      pwndbg
      one_gadget

      (customPython.withPackages (python-pkgs:
        with python-pkgs; [
          pwntools
          docker
          angr
          ropper
          (callPackage (import ./pkgs/getlibs) {})
          #python-lsp-server
        ]))

      rubyPackages_3_4.seccomp-tools

      radare2
      cutter

      aflplusplus
    ];

    inputsFrom = with pkgs; [libgcc qemu gnumake];
  }
