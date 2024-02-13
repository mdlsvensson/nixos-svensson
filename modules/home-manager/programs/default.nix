{
  imports = [
    ./zsh.nix
    ./kitty.nix
    ./nixvim.nix
    ./i3status-rust.nix
    ./rofi.nix
    ./vscode.nix
    ./mpv.nix
    ./firefox.nix
    ./git.nix
    ./starship.nix
    ./eza.nix
    ./fzf.nix
    ./nnn.nix
    ./gh.nix
    ./direnv.nix
  ];

  programs = {
    lazygit.enable = true;
    zoxide.enable = true;
    nix-index.enable = true;
    bat.enable = true;
    home-manager.enable = true;
  };
}