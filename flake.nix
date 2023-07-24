{
  description = "NixOS flake dektop/laptop/servers, beginner-friendly commenting (https://github.com/mdlsvensson)";

  inputs = {
    # Unstable channel for packages that need it.
    # https://channels.nixos.org/
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # mdlsvensson/nixos-setup-config | NixOS module for defining local configuration data: https://github.com/mdlsvensson/nixos-setup-config
    setup-config.url = "github:mdlsvensson/nixos-setup-config";
    setup-config.inputs.nixpkgs.follows = "nixpkgs";
    # nix-community/nixvim | Configure Neovim with Nix: https://github.com/nix-community/nixvim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    # Misterio77/nix-colors | Modules and schemes to make theming with Nix awesome: https://github.com/Misterio77/nix-colors
    nix-colors.url = "github:misterio77/nix-colors";
    nix-colors.inputs.nixpkgs.follows = "nixpkgs";

    # nix-community/home-manager | Manage a user environment using Nix: https://github.com/nix-community/home-manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, unstable, setup-config, nixvim, nix-colors, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      host = "laptop";
      user = {
        username = "mdlsvensson";
        homeDirectory = /home/mdlsvensson;
      };
      git = {
        userName = "mdlsvensson";
        userEmail = "wilmer.lindau@gmail.com";
      };
    in {
      nixosConfigurations = {
        nixosHost = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            setup-config.nixosModules.setupConfig { setupConfig = { inherit host user git; }; }
            ./modules/configuration.nix
          ];
        };
      };
    };
}
