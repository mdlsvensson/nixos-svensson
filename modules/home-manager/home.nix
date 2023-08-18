{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.username = ${user};
  home.homeDirectory = ${homePath};
  # home.packages = with pkgs; [];

  nixpkgs.allowUnfree = true;
  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.allowUnfree = allowUnfreePredicate = (_: true);

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