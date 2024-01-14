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
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "explorer.confirmDragAndDrop" = false;
      "explorer.confirmDelete" = false;
      "workbench.editor.untitled.hint" = "hidden";
      "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = true;
          "scminput" = false;
      };
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
      "editor.fontSize" = 14;
      "files.trimTrailingWhitespace" = true;
      "git.autofetch" = true;
      "security.workspace.trust.untrustedFiles" = "open";
      "godot_tools.gdscript_lsp_server_port" = 6005;
      "workbench.colorTheme" = "SpaceShaman Dark";
      "cSpell" = {
        "enabledLanguageIds" = [
          "markdown"
        ];
        "userWords" = [
          "Frostfire"
        ];
      };
    };
  };
}