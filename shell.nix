{
  pkgs ? import <nixpkgs> {},
  pkgs-stable ? import <nixpkgs-stable> {},
}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs:
      with python-pkgs; [
        # select Python packages here
        pwntools
        #pandas
        #requests
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        # select Python packages here
        angr
        #pandas
        #requests
      ]))
  ];

  inputsFrom = [pkgs.pwntools pkgs.radare2];

  shellHook = ''
    exec zsh
  '';
}
