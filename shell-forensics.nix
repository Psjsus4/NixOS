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
        pyshark
        binwalk-full
      ]))

    (pkgs-stable.python3.withPackages (python-pkgs:
      with python-pkgs; [
        #something
      ]))
    tshark
    dislocker
  ];

  inputsFrom = with pkgs; [wireshark]; #[something];
}
