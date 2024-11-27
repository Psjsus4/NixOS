{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        pycryptodome
        #pandas
        #requests
      ]))

    john
    crunch
  ];

  inputsFrom = with pkgs; [john crunch];
}
