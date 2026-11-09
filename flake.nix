{
  description = "The nixos setup of Peter Varnai";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    opencode.url = "github:anomalyco/opencode";

    mattpocock-skills = {
      url = "github:mattpocock/skills";
      flake = false;
    };

    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      opencode,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        dev = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/peters_machine/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = { inherit inputs; };

                users.peter = import ./hosts/peters_machine/home.nix;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        petervarnai = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./hosts/foreus/home.nix ];
        };

        debian = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./hosts/debian/home.nix ];
        };
      };
    };
}
