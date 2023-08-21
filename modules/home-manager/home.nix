{ inputs, config, pkgs, ... }:
{
  # imports = [
  #   inputs.nix-colors.homeManagerModule
  #   inputs.nixvim.homeManagerModules.nixvim
  # ];

  # colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.username = "mdlsvensson";
  home.homeDirectory = "/home/mdlsvensson";
  # home.packages = with pkgs; [];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs = {
    git = {
      enable = true;
      userName  = "mdlsvensson";
      userEmail = "wilmer.lindau@gmail.com";
    };
    firefox.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}