{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs:
      with python-pkgs; [
        # select Python packages here
        pwntools
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
