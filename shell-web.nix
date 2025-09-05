{pkgs ? import <nixpkgs> {config.allowUnfree = true;}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        #pandas
        requests
        pyngrok
        beautifulsoup4
        flask
      ]))

    ngrok
    commix
    sqlmap
  ];
}
