{
  description = "Home Manager configuration of darktar";

  inputs = {
    # Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Stylix
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # Pwndbg
    pwndbg.url = "github:pwndbg/pwndbg";
    pwndbg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pwndbg-pkgs = inputs.pwndbg.packages.${system}.default;
    #lib = nixpkgs.lib;
  in {
    homeConfigurations."darktar" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [stylix.homeManagerModules.stylix ./home.nix];
      extraSpecialArgs = {pwndbg = pwndbg-pkgs;};
      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
