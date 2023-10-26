{ pkgs, ... }: {
  programs.nnn.enable = true;
  programs.nnn.package = pkgs.nnn.override ({ withNerdIcons = true; });
}