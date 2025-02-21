{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pillow
        #requests
      ]))
  ];

  inputsFrom = with pkgs; []; #[something];
}
