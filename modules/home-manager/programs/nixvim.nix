{
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
}