{
  pkgs ? import <nixpkgs> {},
  pwndbg,
  ...
}: let
  # Override pwntools with the patched commit
  customPython = pkgs.python3.override {
    packageOverrides = self: super: {
      pwntools = super.pwntools.overrideAttrs (old: {
        version = "4.14.1-10-gb133b76b";
        src = pkgs.fetchFromGitHub {
          owner = "Gallopsled";
          repo = "pwntools";
          rev = "b133b76b4e16a15c753cf243893a6ba398b67aff";
          sha256 = "06s9cvjnj2la0gq5rbkr30z914s3dym66i7sya7pq7v5xqxjr6bk";
        };
      });
    };
  };
in
  pkgs.mkShell {
    packages = with pkgs; [
      qemu
      musl
      libgcc
      pwndbg
      one_gadget

      (customPython.withPackages (python-pkgs:
        with python-pkgs; [
          pwntools
          docker
          ropper
        ]))

      rubyPackages_3_4.seccomp-tools

      radare2
      cutter

      aflplusplus
    ];
  }
