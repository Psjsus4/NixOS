{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pyshark
      ]))

    tshark
    dislocker
    tcpdump
  ];

  inputsFrom = with pkgs; [wireshark tcpdump]; #[something];
}
