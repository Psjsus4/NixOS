{
  pkgs ? import <nixpkgs> {},
  pkgs-stable ? import <nixpkgs-stable> {},
  ...
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pwntools
        pycryptodome
        #pandas
        #requests
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        #something
      ]))
    john
    crunch
  ];

  inputsFrom = with pkgs; [john crunch];
}
