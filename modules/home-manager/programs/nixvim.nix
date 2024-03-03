{
  programs.nixvim = {
    enable = true;
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
        servers = {
          omnisharp.enable = true;
          gdscript.enable = true;
          nil_ls.enable = true;
          bashls.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = true;
          eslint.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
          pyright.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };

      telescope = {
        enable = true;
        extensions.file_browser.enable = true;
      };

      lualine.enable = true;
      treesitter.enable = true;
      barbar.enable = true;
      illuminate.enable = true;
      nvim-autopairs.enable = true;

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
    };
  };
}