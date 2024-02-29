{
  description = "Personal NixOS configuration for dektop.";

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

    # Local flakes
    setup-config.url = "/home/mdlsvensson/Repo/nixos-setup-config";
  };

  outputs = { nixpkgs, nixvim, nix-colors, home-manager, setup-config, ... } @ inputs:
    {
      nixosConfigurations = {
        svensson = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/hardware-configuration.nix      # generated hardware config
            ./modules                                 # top-level module
            ./modules/hosts/${setup-config.host}.nix  # desktop/laptop module
            home-manager.nixosModules.home-manager {  # home-manager as module
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
