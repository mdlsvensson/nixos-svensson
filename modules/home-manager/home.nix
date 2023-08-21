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
    
    zsh = {
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

    rofi = {
      enable = true;
      font = "JetBrains Mono Nerdfont 14";
      # theme = {
      #   "*" = {
      #     background-color = mkLiteral "transparent";
      #     text-color = mkLiteral "#${colors.base04}";

      #     margin = mkLiteral "0px";
      #     padding = mkLiteral "0px";
      #     spacing = mkLiteral "0px";
      #   };
      #   "window" = {
      #     location = mkLiteral "north";
      #     width = mkLiteral "100%";
      #     background-color = mkLiteral "#${colors.base00}";
      #     children = mkLiteral "[ mainbox, message ]";
      #   };
      #   "mainbox" = {
      #     orientation = mkLiteral "horizontal";
      #     children = mkLiteral "[ inputbar, listview ]";
      #   };
      #   "inputbar" = {
      #     width = mkLiteral "25%";
      #     padding = mkLiteral "1px 8px";
      #     spacing = mkLiteral "8px";
      #     children = mkLiteral "[ prompt, entry ]";
      #   };
      #   "prompt, entry, element-text, element-icon" = {
      #     vertical-align = mkLiteral "0.5";
      #   };
      #   "prompt" = {
      #     text-color = mkLiteral "#${colors.base07}";
      #   };
      #   "listview" = {
      #     layout = mkLiteral "horizontal";
      #   };
      #   "element" = {
      #     padding = mkLiteral "1px 8px";
      #     spacing = mkLiteral "4px";
      #   };
      #   "element normal urgent" = {
      #     text-color = mkLiteral "#00FF00";
      #   };
      #   "element normal active" = {
      #     text-color = mkLiteral "#FF0000";
      #   };
      #   "element selected" = {
      #     text-color = mkLiteral "#${colors.base00}";
      #   };
      #   "element selected normal" = {
      #     background-color = mkLiteral "#${colors.base07}";
      #   };
      #   "element selected urgent" = {
      #     background-color = mkLiteral "#00FF00";
      #   };
      #   "element selected active" = {
      #     background-color = mkLiteral "#0000FF";
      #   };
      #   "element-icon" = {
      #     size = mkLiteral "0.75em";
      #   };
      #   "element-text" = {
      #     text-color = mkLiteral "inherit";
      #   };
      # };
    };

    kitty = {
      enable = true;
      font.name = "JetBrains Mono Nerd Font";
      font.size = 12;
      settings = {
        shell = "zsh";
        confirm_os_window_close = 0; 
        scrollback_lines = 4000;
        scrollback_pager_history_size = 2048;
        window_padding_width = 10;
        # foreground = "#${colors.base05}";
        # background = "#${colors.base00}";
        # selection_background = "#${colors.base05}";
        # selection_foreground = "#${colors.base00}";
        # url_color = "#${colors.base04}";
        # cursor = "#${colors.base05}";
        # active_border_color = "#${colors.base03}";
        # inactive_border_color = "#${colors.base01}";
        # active_tab_background = "#${colors.base00}";
        # active_tab_foreground = "#${colors.base05}";
        # inactive_tab_background = "#${colors.base01}";
        # inactive_tab_foreground = "#${colors.base04}";
        # tab_bar_background = "#${colors.base01}";
        # color0 = "#${colors.base00}";
        # color1 = "#${colors.base08}";
        # color2 = "#${colors.base0B}";
        # color3 = "#${colors.base0A}";
        # color4 = "#${colors.base0D}";
        # color5 = "#${colors.base0E}";
        # color6 = "#${colors.base0C}";
        # color7 = "#${colors.base05}";
        # color8 = "#${colors.base03}";
        # color9 = "#${colors.base08}";
        # color10 = "#${colors.base0B}";
        # color11 = "#${colors.base0A}";
        # color12 = "#${colors.base0D}";
        # color13 = "#${colors.base0E}";
        # color14 = "#${colors.base0C}";
        # color15 = "#${colors.base07}";
        # color16 = "#${colors.base09}";
        # color17 = "#${colors.base0F}";
        # color18 = "#${colors.base01}";
        # color19 = "#${colors.base02}";
        # color20 = "#${colors.base04}";
        # color21 = "#${colors.base06}";
      };
    };

    nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = true;
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
      options = {
        backspace = "2";
        showcmd = true;
        laststatus = 2;
        autowrite = true;
        cursorline = true;
        autoread = true;
        number = true;
        relativenumber = true;
        tabstop = 4;
        shiftwidth = 4;
        shiftround = true;
        expandtab = true;
        autoindent = true;
      };
      plugins = {
        lsp = {
          enable = true;
          # Main
          servers.omnisharp.enable = true;
          servers.rust-analyzer.enable = true;
          servers.gdscript.enable = true;
          # System
          servers.nil_ls.enable = true;
          servers.bashls.enable = true;
          # Web
          servers.html.enable = true;
          servers.cssls.enable = true;
          servers.tailwindcss.enable = true;
          servers.eslint.enable = true;
          # Other
          servers.jsonls.enable = true;
          servers.lua-ls.enable = true;
          servers.pyright.enable = true;
        };

        telescope = {
          enable = true;
          extensions.file_browser.enable = true;
        };

        lualine.enable = true;
        treesitter.enable = true;
        barbar.enable = true;
        illuminate.enable = true;
        alpha = {
          enable = true;
          layout = [
            {
              type = "padding";
              val = 2;
            }
            {
              opts = {
                hl = "Type";
                position = "center";
              };
              type = "text";
              val = [
                " ___  ___ ____   __     __  __ __  ____ __  __  __   __    ___   __  __ "
                " ||\\//|| || \\  ||    (( \ || || ||    ||\ || (( \ (( \  // \\  ||\ || "
                " || \/ || ||  )) ||     \\  \\ // ||==  ||\\||  \\   \\  ((   )) ||\\|| "
                " ||    || ||_//  ||__| \_))  \V/  ||___ || \|| \_)) \_))  \\_//  || \|| "
              ];
            }
            {
              type = "padding";
              val = 2;
            }
            {
              type = "group";
              val = [
              {
                command = "<CMD>ene <CR>";
                desc = "  New file";
                shortcut = "e";
              }
              {
                command = ":qa<CR>";
                desc = "  Quit Neovim";
                shortcut = "LDR q";
              }
              ];
            }
            {
              type = "padding";
              val = 2;
            }
            {
              opts = {
                hl = "Keyword";
                position = "center";
              };
              type = "text";
              val = "Inspiring quote here.";
            }
          ];
        };
        nvim-autopairs.enable = true;
      };
    };

    lazygit.enable = true;
    vscode.enable = true;
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