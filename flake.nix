{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # NUR
    #nur.url = "github:nix-community/NUR";
    #nur.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Stylix
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # nix your shell
    nix-your-shell.url = "github:MercuryTechnologies/nix-your-shell";
    nix-your-shell.inputs.nixpkgs.follows = "nixpkgs";

    # Pwndbg
    pwndbg.url = "github:pwndbg/pwndbg";
    pwndbg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    #nixpkgs-stable,
    #nur,
    #home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pwndbg = inputs.pwndbg.packages.${system}.default;
    # pkgs-nur = nur.legacyPackages.${system};
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
  in {
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = pkgs.alejandra;

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs outputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      psjsus4 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    devShells.${system} = {
      default = import ./shell-pwn.nix {
        inherit pkgs pwndbg;
      };
      pwn = import ./shell-pwn.nix {
        inherit pkgs pwndbg;
      };
      rev = import ./shell-rev.nix {inherit pkgs;};
      osint = import ./shell-osint.nix {inherit pkgs;};
      crypto = import ./shell-crypto.nix {inherit pkgs;};
      web = import ./shell-web.nix {inherit pkgs;};
      forensics = import ./shell-forensics.nix {inherit pkgs;};
      blockchain = import ./shell-blockchain.nix {inherit pkgs;};
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    #homeConfigurations = {
    #  # FIXME replace with your username@hostname
    #  "darktar@psjsus4" = home-manager.lib.homeManagerConfiguration {
    #    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    #    extraSpecialArgs = {inherit inputs outputs;};
    #    modules = [
    #      # > Our main home-manager configuration file <
    #      ./home-manager/home.nix
    #    ];
    #  };
    #};
  };
}
