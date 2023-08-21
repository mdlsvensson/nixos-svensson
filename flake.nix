{
  description = "Personal NixOS configuration for dektop/laptop - nothing fancy.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";                            # https://channels.nixos.org/
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";                            # https://github.com/nix-community/nixvim
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";                       # https://github.com/Misterio77/nix-colors
    nix-colors.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.05";  # https://github.com/nix-community/home-manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, unstable, nixvim, nix-colors, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";  # System architecture
      host = "laptop";          # The configuration to apply
    in {
      nixosConfigurations = {
        svensson = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/hardware-configuration.nix      # nixos-generate-config --show-hardware-config > hardware-configuration.nix
            ./modules/configuration.nix               # Global config
            ./modules/hosts/${host}.nix               # Host specific
            home-manager.nixosModules.home-manager {  # https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."mdlsvensson" = import ./modules/home-manager/home.nix;
            }
          ];
        };
      };
    };
}
