{ inputs, config, pkgs, ... }:
rec {
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
    ./userDirs.nix
    ./packages.nix
    ./home.nix
    ./programs
  ];

  colorScheme = inputs.nix-colors.colorSchemes.ayu-dark;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  services = {
    redshift = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 5000;
      latitude = "59.32";
      longitude = "18.06";
    };
    unclutter.enable = true; # Hides cursor
    # lorri.enable = true;
  };

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
