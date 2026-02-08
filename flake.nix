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
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    agenix.url = "github:ryantm/agenix";

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    dotfiles = {
      url = "git+https://github.com/Hibbidt/dotfiles.git";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs, # home-manager, agenix, mango, dotfiles, nvf, nixos-hardware, stylix,
      ...
    }@inputs:
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
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        FWL12 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/FWL12
            inputs.agenix.nixosModules.default
            inputs.nixos-hardware.nixosModules.framework-12-13th-gen-intel
            inputs.stylix.nixosModules.stylix
          ];
        };
      };

      homeConfigurations = {
        "corvus@FWL12" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/corvus/FWL12.nix
          ];
          inputs.home-manager.backupFileExtension = "backup";
        };
      };
    };
}
