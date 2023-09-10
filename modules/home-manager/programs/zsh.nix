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
    flake-build = "sudo nixos-rebuild build --flake ~/Repo/nixos-svensson/#svensson";
    flake-switch = "sudo nixos-rebuild switch --flake ~/Repo/nixos-svensson/#svensson";
    flake-update = "nix flake update /home/mdlsvensson/Repo/nixos-svensson";
    env-gen = "nix-env --list-generations";
    # Lazygit
    lg = "lazygit";
    lgnix = "lazygit -p ~/Repo/nixos-svensson";
    # SSH
    ssh-eval = ''eval "$(ssh-agent -s)"'';
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
  function garbage() {
    if [ $# -eq 0 ]; then
      >&2 echo "No arguments provided"
      return 1
    fi
    nix-env --delete-generations $1
    nix-store --gc
  }

  function clone() {
    if [ $# -eq 0 ]; then
      >&2 echo "No arguments provided"
      return 1
    fi
    gh repo clone $1
  }
  '';
  dotDir = ".config/zsh";
}