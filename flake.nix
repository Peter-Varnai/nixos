{
  description = "The nixos setup of Peter Varnai";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    opencode.url = "github:anomalyco/opencode";
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
        peter = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./hosts/foreus/home.nix ];
        };

        "peter@macbook" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./hosts/macbook/home.nix ];
        };
      };
    };
}
