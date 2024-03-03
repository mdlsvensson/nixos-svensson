{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
    ./home.nix
    ./services.nix
    ./xdg.nix
    ./packages.nix
    ./programs
  ];

  colorScheme = inputs.nix-colors.colorSchemes.ayu-dark;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  gtk = {
    enable = true;
    font.name = "Iosevka Nerd Font Bold 10";
    theme = {
      package = pkgs.ayu-theme-gtk;
      name = "Ayu-Dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
