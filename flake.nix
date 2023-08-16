{
  description = "NixOS flake dektop/laptop/servers, beginner-friendly commenting (https://github.com/mdlsvensson)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";                           # https://channels.nixos.org/
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";                 # Unstable channel for packages that need it.
    setup-config.url = "github:mdlsvensson/nixos-setup-config";           # https://github.com/mdlsvensson/nixos-setup-config
    setup-config.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";                           # https://github.com/nix-community/nixvim
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";                      # https://github.com/Misterio77/nix-colors
    nix-colors.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.05"; # https://github.com/nix-community/home-manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, unstable, setup-config, nixvim, nix-colors, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";                 # System architecture
      host = "laptop";                         # The configuration to apply
      initrd.kernelModules = [ "amdgpu" ];     # Init kernel modules
      xserver.videoDrivers = [ "amdgpu" ];     # Graphics driver
      user = {                                 # Main user account
        username = "mdlsvensson";
        homeDirectory = /home/mdlsvensson;
      };
      git = {                                  # Git details
        userName = "mdlsvensson";
        userEmail = "wilmer.lindau@gmail.com";
      };
      timeZone = "Europe/Stockholm";
      locale = "en_US.UTF-8";
    in {
      nixosConfigurations = {
        nixosHost = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            setup-config.nixosModules.setupConfig {                                             # Passing above to config.setupConfig
              setupConfig = { inherit host initrd xserver user git timeZone locale; };
            }
            ./modules/hardware-configuration.nix                                                # nixos-generate-config --show-hardware-config > hardware-configuration.nix
            ./modules/configuration.nix                                                         # Global config
            ./modules/hosts/${host}                                                             # Host specific setup
            home-manager.nixosModules.home-manager {                                            # https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user.username} = import ./modules/home-manager/home.nix;
            }
          ];
        };
      };
    };
}
