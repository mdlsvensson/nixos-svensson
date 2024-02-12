{ pkgs, ... }: {
  programs.vscode.enable = true;
  programs.vscode = {
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      nil
    ]);
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