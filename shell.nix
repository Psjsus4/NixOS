{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs:
      with python-pkgs; [
        # select Python packages here
        pwntools

        #pandas
        #requests
      ]))
  ];

  inputsFrom = [pkgs.pwntools];

  shellHook = ''
    exec zsh
  '';
}
