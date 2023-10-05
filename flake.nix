{
  description = "Personal NixOS configuration for dektop/laptop - nothing fancy.";

  inputs = {
    # https://channels.nixos.org/
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # https://github.com/nix-community/nixvim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    
    # https://github.com/Misterio77/nix-colors
    nix-colors.url = "github:misterio77/nix-colors";
    base16-schemes.url = "github:mdlsvensson/base16-schemes";
    base16-schemes.flake = false;
    nix-colors.inputs.base16-schemes.follows = "base16-schemes";

    # https://github.com/nix-community/home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Machine specific variables
    setup-config.url = "/home/mdlsvensson/Repo/nixos-setup-config";
  };

  outputs = { nixpkgs, nixvim, nix-colors, home-manager, setup-config, ... } @ inputs:
    {
      nixosConfigurations = {
        svensson = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/hardware-configuration.nix      # nixos-generate-config --show-hardware-config > hw-desktop.nix
            ./modules/configuration.nix               # Global config
            ./modules/hosts/${setup-config.host}.nix               # Host specific
            home-manager.nixosModules.home-manager {  # https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."mdlsvensson" = import ./modules/home-manager/home.nix;
            }
          ];
        };
      };
    };
}
