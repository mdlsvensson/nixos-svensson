{ inputs, user, homePath, git, pkgs, ... }:
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
    git.enable = true;
    git.userName = git.user;
      enable = true;
      userName  = "mdlsvensson";
      userEmail = "wilmer.lindau@gmail.com";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}