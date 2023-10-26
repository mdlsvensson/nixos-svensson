{ inputs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
    ./userDirs.nix
    ./packages.nix
    ./home.nix
    ./redshift.nix
    ./gtk.nix
    ./programs
  ];

  colorScheme = inputs.nix-colors.colorSchemes.ayu-dark;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  services.unclutter.enable = true;
  services.lorri.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
