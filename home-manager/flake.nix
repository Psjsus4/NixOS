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
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    #lib = nixpkgs.lib;
  in {
    homeConfigurations."darktar" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [stylix.homeManagerModules.stylix ./home.nix];
      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
