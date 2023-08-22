{
  zsh = import ./zsh.nix
  rofi = import ./rofi.nix
  kitty = import ./kitty.nix
  nixvim = import ./nixvim.nix
  git = {
    enable = true;
    userName  = "mdlsvensson";
    userEmail = "wilmer.lindau@gmail.com";
  };
  firefox = {
    enable = true;
    profiles."mdlsvensson".name = "mdlsvensson";
    profiles."mdlsvensson".isDefault = true;
  };
  starship = {
    enable = true;
    settings.add_newline = true;
  };
  exa = {
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
  lazygit.enable = true;
  vscode.enable = true;
  zoxide.enable = true;
  nix-index.enable = true;
  bat.enable = true;
  mpv.enable = true;
  # direnv.enable = true;
  home-manager.enable = true;
}