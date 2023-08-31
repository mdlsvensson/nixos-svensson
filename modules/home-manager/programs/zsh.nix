{
  enable = true;
  history.size = 10000;
  history.path = "/home/mdlsvensson/.config/zsh/history";
  shellAliases = {
    # General
    fz = "fzf";
    cd = "z";
    vi = "nvim";
    ls = "exa -a";
    # NixOS
    rebuild = "sudo nixos-rebuild build --flake ~/nixos-svensson/#svensson";
    reswitch = "sudo nixos-rebuild switch --flake ~/nixos-svensson/#svensson";
    nixup = "nix flake update /home/mdlsvensson/nixos-svensson";
    nixgen = "nix-env --list-generations";
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
      { name = "zsh-users/zsh-syntax-highlighting"; }
    ];
  };
  initExtra = ''
    bindkey '^I' autosuggest-accept
  '';
  envExtra = ''
  function nixgc() {
    if [ $# -eq 0 ]; then
      >&2 echo "No arguments provided"
      return 1
    fi
    nix-env --delete-generations $1
    nix-store --gc
  }
  '';
  dotDir = ".config/zsh";
}