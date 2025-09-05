{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        requests
        pillow
        img2pdf
        pypdf2
        #requests
      ]))
  ];
}
