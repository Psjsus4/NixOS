{
  pkgs ? import <nixpkgs> {},
  pkgs-stable ? import <nixpkgs-stable> {},
  ...
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        #pandas
        #requests
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        #something
      ]))
  ];

  inputsFrom = with pkgs; []; #[something];
}
