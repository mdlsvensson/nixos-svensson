{ inputs, config, pkgs, ... }:
let
  catppuccin_name = "Catppuccin-Macchiato-Compact-Pink-dark";
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "pink" ];
    size = "compact";
    tweaks = [ "normal" ];
    variant = "macchiato";
  };
in
{
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

  home = {
    username = "mdlsvensson";
    homeDirectory = "/home/mdlsvensson";
    packages = with pkgs; [
      godot_4                 # Godot Engine
      blender-hip             # Blender
      wings                   # Wings3D
      qbittorrent             # Torrent client
      gimp                    # Image editor
      steam                   # Steam
      jetbrains-toolbox       # Jetbrains Toolbox
      tor-browser-bundle-bin  # Tor Browser
    ];
    file = {
      # i3wm
      ".config/i3".source = ../../dots/i3;
      ".background-image".source = ../../dots/.background-image;
      # xrandr
      ".config/.screenlayout".source = ../../dots/.screenlayout;
      # vscode
      ".config/Code/User/profiles".source = ../../dots/Code/User/profiles;
    };
  };

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
      XDG_REPO_PATH = "${config.home.homeDirectory}/Repo";
      XDG_GAMES_PATH = "${config.home.homeDirectory}/Games";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = catppuccin_name;
      package = catppuccin;
    };
    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
  };

  programs = {
    zsh = import ./programs/zsh.nix;
    kitty = import ./programs/kitty.nix { inherit (config.colorScheme) colors; };
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
    vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (ps: with ps; [
        nil
      ]);
    };
    lazygit.enable = true;
    zoxide.enable = true;
    nix-index.enable = true;
    bat.enable = true;
    mpv.enable = true;
    gh.enable = true;
    # direnv.enable = true;
    home-manager.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
