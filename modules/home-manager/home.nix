{ inputs, config, pkgs, ... }:
let
  catppuccin_name = "Catppuccin-Macchiato-Standard-Green-Dark";
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "green" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "macchiato";
  };
in
{
  imports = [
    inputs.nix-colors.homeManagerModule
    #inputs.nixvim.homeManagerModules.nixvim
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home = {
    username = "mdlsvensson";
    homeDirectory = "/home/mdlsvensson";
    # packages = with pkgs; [  ];
    file = {
      # i3wm
      ".config/i3".source = ../../dots/i3;
      # xrandr
      ".screenlayout".source = ../../dots/.screenlayout;
      # gtk
      ".config/gtk-4.0/gtk.css".source = "${catppuccin}/share/themes/${catppuccin_name}/gtk-4.0/gtk.css";
      ".config/gtk-4.0/gtk-dark.css".source = "${catppuccin}/share/themes/${catppuccin_name}/gtk-4.0/gtk-dark.css";
      ".config/gtk-4.0/assets" = {
        recursive = true;
        source = "${catppuccin}/share/themes/${catppuccin_name}/gtk-4.0/assets";
      };
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
    kitty = import ./programs/kitty.nix;
    #nixvim = import ./programs/nixvim.nix;
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
    # direnv.enable = true;
    home-manager.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
