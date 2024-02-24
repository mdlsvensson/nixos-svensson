{ pkgs, ... }:
  let
    system = pkgs.system;
    extensions =
      (import (builtins.fetchGit {
        url = "https://github.com/nix-community/nix-vscode-extensions";
        ref = "refs/heads/master";
        rev = "728418f4de5d01d4c4997a99a11afeb69f3da104";
      })).extensions.${system};
  in
  {
  programs.vscode.enable = true;
  programs.vscode = {
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      nil
    ]);
    extensions = with extensions.vscode-marketplace; [
      geequlim.godot-tools
      bedirt.gpt-token-counter-live
      spaceshaman.spaceshaman-dark
      streetsidesoftware.code-spell-checker
      dcasella.i3
      sumneko.lua
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
      dlasagno.rasi
      eddiedover.gdscript-formatter-linter
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cmake-tools
    ];
    keybindings = [
      {
        key = "ctrl+alt+p";
        command = "git.push";
      }
    ];
    userSettings = {
      "window.menuBarVisibility" = "toggle";

      "workbench" = {
        "editor.untitled.hint" = "hidden";
        "colorTheme" = "SpaceShaman Dark";
      };

      "explorer" = {
        "confirmDragAndDrop" = false;
        "confirmDelete" = false;
      };

      "editor" = {
        "fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
        "fontSize" = 14;
      };

      "security.workspace.trust.untrustedFiles" = "open";
      "files.trimTrailingWhitespace" = true;
      "git.autofetch" = true;

      "nix" = {
        "enableLanguageServer" = true;
        "serverPath" = "nil";
      };

      "godot_tools.gdscript_lsp_server_port" = 6005;
      "cSpell.enabledLanguageIds" = [ "markdown" ];
    };
  };
}