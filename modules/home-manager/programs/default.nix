{ config, pkgs, ... }: {
  zsh = import ./zsh.nix;
  kitty = import ./kitty.nix { inherit config; };
  nixvim = import ./nixvim.nix;
  i3status-rust = import ./i3status-rust.nix;
  rofi = import ./rofi.nix { inherit config pkgs; };
  git = {
    enable = true;
    userName  = "mdlsvensson";
    userEmail = "wilmer.lindau@gmail.com";
  };
  firefox = import ./firefox.nix;
  starship = {
    enable = true;
    settings.add_newline = true;
  };
  eza = {
    enable = true;
    icons = true;
  };
  fzf = {
    enable = true;
    defaultCommand = "fd --type f";
  };
  nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
  };
  vscode = import ./vscode.nix { inherit pkgs; };
  gh = {
    enable = true;
    settings.editor = "nvim";
  };
  mpv = import ./mpv.nix { inherit pkgs; };
  lazygit.enable = true;
  zoxide.enable = true;
  nix-index.enable = true;
  bat.enable = true;
  # direnv.enable = true;
  home-manager.enable = true;
}