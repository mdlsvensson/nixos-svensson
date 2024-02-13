{
  programs.nixvim.enable = true;
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = " ";
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
    plugins.lsp.enable = true;
    # Main
    plugins.lsp.servers.omnisharp.enable = true;
    plugins.lsp.servers.rust-analyzer = {
      enable = true;
      installCargo = true;
      installRustc = true;
    };
    plugins.lsp.servers.gdscript.enable = true;
    # System
    plugins.lsp.servers.nil_ls.enable = true;
    plugins.lsp.servers.bashls.enable = true;
    # Web
    plugins.lsp.servers.html.enable = true;
    plugins.lsp.servers.cssls.enable = true;
    plugins.lsp.servers.tailwindcss.enable = true;
    plugins.lsp.servers.eslint.enable = true;
    # Other
    plugins.lsp.servers.jsonls.enable = true;
    plugins.lsp.servers.lua-ls.enable = true;
    plugins.lsp.servers.pyright.enable = true;

    plugins.telescope.enable = true;
    plugins.telescope.extensions.file_browser.enable = true;
    plugins.lualine.enable = true;
    plugins.treesitter.enable = true;
    plugins.barbar.enable = true;
    plugins.illuminate.enable = true;
    plugins.nvim-autopairs.enable = true;

    plugins.alpha.enable = true;
    plugins.alpha.layout = [
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
}