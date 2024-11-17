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
        gef
        #pandas
        #requests
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        angr
      ]))
    radare2
  ];

  inputsFrom = with pkgs; [libgcc gef];
}
