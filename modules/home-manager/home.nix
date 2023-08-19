{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.username = config.setupConfig.user.username;
  home.homeDirectory = config.setupConfig.user.homeDirectory;
  # home.packages = with pkgs; [];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs = {
    git = {
      enable = true;
      userName  = config.setupConfig.git.userName;
      userEmail = config.setupConfig.git.userEmail;
    };
    vscodium.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}