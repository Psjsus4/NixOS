{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pyshark
      ]))

    tshark
    dislocker
  ];

  inputsFrom = with pkgs; [wireshark]; #[something];
}
