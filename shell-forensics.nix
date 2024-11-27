{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pyshark
        binwalk-full
      ]))

    tshark
    dislocker
  ];

  inputsFrom = with pkgs; [wireshark]; #[something];
}
