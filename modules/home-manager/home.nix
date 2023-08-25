{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.username = "mdlsvensson";
  home.homeDirectory = "/home/mdlsvensson";
  home.packages = with pkgs; [ vscodium-fhs ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  services = {
    redshift = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 5000;
      latitude = "59.32";
      longitude = "18.06";
    };
    unclutter.enable = true;
    # lorri.enable = true;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    pictures = "${config.home.homeDirectory}/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    desktop = null;
    music = null;
    publicShare = null;
    videos = null;
    extraConfig = {
      XDG_WORKSPACES_PATH = "${config.home.homeDirectory}/Workspaces";
    };
  };

  programs = {
    zsh = import ./programs/zsh.nix;
    rofi = import ./programs/rofi.nix;
    kitty = import ./programs/kitty.nix;
    nixvim = import ./programs/nixvim.nix;
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
    zoxide.enable = true;
    nix-index.enable = true;
    bat.enable = true;
    mpv.enable = true;
    # direnv.enable = true;
    home-manager.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}