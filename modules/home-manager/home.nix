{ inputs, config, pkgs, ... }:
rec {
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
  ];

  colorScheme = inputs.nix-colors.colorSchemes.ayu-dark;

  home = {
    username = "mdlsvensson";
    homeDirectory = "/home/mdlsvensson";
    packages = with pkgs; [
      godot_4                 # Godot Engine
      blender-hip             # Blender
      wings                   # Wings3D
      qbittorrent             # Torrent client
      gimp                    # Image editor
      tor-browser-bundle-bin  # Tor Browser
      r2mod_cli               # Risk of Rain 2 mod manager
      r2modman                # Risk of Rain 2 mod manager
    ];

    file = {
      # wallpaper
      "Pictures/wallpaper.png".source = ../../wallpaper.png;
      # i3wm
      ".config/i3".source = ../../dots/i3;
      # mpv
      ".config/mpv".source = ../../dots/mpv;
    };

    # https://github.com/nix-community/home-manager/issues/1800 (workaround)
    activation.boforeCheckLinkTargets = {
      after = [];
      before = [ "checkLinkTargets" ];
      data = ''
        userDir=/home/mdlsvensson/.config/Code/User
        rm -rf $userDir/settings.json
      '';
    };
    activation.afterWriteBoundary = {
      after = [ "writeBoundary" ];
      before = [];
      data = ''
        userDir=/home/mdlsvensson/.config/Code/User
        rm -rf $userDir/settings.json
        cat \
          ${(pkgs.formats.json {}).generate "blabla"
            programs.vscode.userSettings} \
          > $userDir/settings.json
      '';
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
    unclutter.enable = true; # Hides cursor
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
    font.name = "Iosevka Nerd Font Bold 10";
    theme = {
      package = pkgs.ayu-theme-gtk;
      name = "Ayu-Dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  programs = {
    zsh = import ./programs/zsh.nix;
    kitty = import ./programs/kitty.nix { inherit config; };
    nixvim = import ./programs/nixvim.nix;
    i3status-rust = import ./programs/i3status-rust.nix;
    rofi = import ./programs/rofi.nix { inherit config; };
    git = {
      enable = true;
      userName  = "mdlsvensson";
      userEmail = "wilmer.lindau@gmail.com";
    };
    firefox = import ./programs/firefox.nix;
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
    vscode = import ./programs/vscode.nix { inherit pkgs; };
    gh = {
      enable = true;
      settings.editor = "nvim";
    };
    mpv = import ./programs/mpv.nix { inherit pkgs; };
    lazygit.enable = true;
    zoxide.enable = true;
    nix-index.enable = true;
    bat.enable = true;
    # direnv.enable = true;
    home-manager.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
