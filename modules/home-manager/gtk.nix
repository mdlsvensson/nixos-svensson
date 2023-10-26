{ pkgs, ... }: {
  gtk.enable = true;
  gtk.font.name = "Iosevka Nerd Font Bold 10";
  gtk.theme.package = pkgs.ayu-theme-gtk;
  gtk.theme.name = "Ayu-Dark";
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus-Dark";
}