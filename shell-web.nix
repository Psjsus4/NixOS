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
        pyngrok
        beautifulsoup4
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        #something
      ]))

    ngrok

    commix

    sqlmap
  ];

  inputsFrom = with pkgs; [ngrok sqlmap]; #[something];
}
