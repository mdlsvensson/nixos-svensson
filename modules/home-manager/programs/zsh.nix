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
    redesk = "sudo nixos-rebuild switch --flake ~/nixos-config/#desktop";
    relap = "sudo nixos-rebuild switch --flake ~/nixos-config/#laptop";
    rehome = "home-manager switch --flake ~/nixos-config/#mdlsvensson";
    # Lazygit
    lg = "lazygit";
    lgnix = "lazygit -p ~/nixos-config";
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