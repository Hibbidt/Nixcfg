{
  description = ''
    This config is basically a copy of Sascha Koenig's Yt series on NixOs

    Other good configs:
    https://github.com/Misterio77/nix-starter-configs
    https://github.com/Misterio77/nix-config
  '';

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    agenix.url = "github:ryantm/agenix";

  dotfiles = {
  url = "git+https://github.com/Hibbidt/dotfiles.git";
  flake = false;
  };
  };

  outputs =
    { self,
    dotfiles,
    agenix
    , home-manager
    , nixpkgs
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        FWL12 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
          ./hosts/FWL12
          agenix.nixosModules.default
          ];
        };
      };
      homeConfigurations = {
        "simon@simon" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/simon/FWL12.nix ];
        };
      };
    };
}
