{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        #pandas
        #requests
        pyngrok
        beautifulsoup4
      ]))

    ngrok

    commix

    sqlmap
  ];

  inputsFrom = with pkgs; [ngrok sqlmap]; #[something];
}
