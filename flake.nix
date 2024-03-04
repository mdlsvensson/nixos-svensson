{
  description = "Personal NixOS configuration for dektop.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16-schemes = {
      url = "github:mdlsvensson/base16-schemes";
      flake = false;
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
      inputs.base16-schemes.follows = "base16-schemes";
    };

    awesome-copycats = {
      url = "github:lcpz/awesome-copycats";
      flake = false;
    };
    awesome-lain = {
      url = "github:lcpz/lain";
      flake = false;
    };
    awesome-freedesktop = {
      url = "github:lcpz/awesome-freedesktop";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    setup-config.url = "/home/mdlsvensson/Repo/nixos-setup-config";
  };

  outputs = { nixpkgs, nixvim, nix-colors, home-manager, setup-config, ... } @ inputs:
    {
      nixosConfigurations = {
        svensson = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/hardware-configuration.nix
            ./modules
            ./modules/hosts/${setup-config.host}.nix
            home-manager.nixosModules.home-manager {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."mdlsvensson" = import ./modules/home-manager;
            }
          ];
        };
      };
    };
}
