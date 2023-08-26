{
  enable = true;
  history.size = 10000;
  history.path = "/home/mdlsvensson/zsh/history";
  shellAliases = {
    # General
    fz = "fzf";
    cd = "z";
    vi = "nvim";
    ls = "exa -a";
    # NixOS
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos-svensson/#svensson";
    # Lazygit
    lg = "lazygit";
    lgnix = "lazygit -p ~/nixos-svensson";
    # SSH
    ghkey = "ssh-keygen -t ed25519 -C wilmer.lindau@gmail.com";
    ssha = ''eval "$(ssh-agent -s)"'';
  };
  zplug = {
    enable = true;
    plugins = [
      { name = "nvbn/thefuck"; }
      { name = "zsh-users/zsh-autosuggestions"; }
    ];
  };
}