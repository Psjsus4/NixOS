{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    checkpwn
    h8mail
  ];

  #inputsFrom = with pkgs; []; #[something];
}
