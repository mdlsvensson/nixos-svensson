{ config, pkgs, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  inherit (config.colorScheme) palette;
in {
  programs.rofi = {
    enable = true;
    location = "center";
    font = "Noto Sans Nerd Font Bold 10";
    extraConfig.modes = "window,run,ssh,drun,calc";
    plugins = with pkgs; [
      rofi-calc
    ];

    theme = {
      "*" = {
        scrollbar = false;

        background = mkLiteral "#${palette.base00}";
        background-color = mkLiteral "@background";
        foreground = mkLiteral "#${palette.base04}";
        foreground-color = mkLiteral "@foreground";
        border-color = mkLiteral "@foreground";
        separatorcolor = mkLiteral "@border-color";
        scrollbar-handle = mkLiteral "@border-color";

        normal-background = mkLiteral "@background";
        normal-foreground = mkLiteral "@foreground";
        alternate-normal-background = mkLiteral "@background";
        alternate-normal-foreground = mkLiteral "@foreground";
        selected-normal-background = mkLiteral "@foreground";
        selected-normal-foreground = mkLiteral "@background";

        active-background = mkLiteral "#${palette.base0A}";
        active-foreground = mkLiteral "@background";
        alternate-active-background = mkLiteral "#${palette.base0A}";
        alternate-active-foreground = mkLiteral "@background";
        selected-active-background = mkLiteral "@foreground";
        selected-active-foreground = mkLiteral "@background";

        urgent-background = mkLiteral "#${palette.base08}";
        urgent-foreground = mkLiteral "@background";
        alternate-urgent-background = mkLiteral "#${palette.base08}";
        alternate-urgent-foreground = mkLiteral "@background";
        selected-urgent-background = mkLiteral "@foreground";
        selected-urgent-foreground = mkLiteral "@background";
      };

      "window" = {
        background-color = mkLiteral "@background";
        border = 2;
        padding = 2;
      };

      "mainbox" = {
        padding = 0;
      };

      "message" = {
        border-color = mkLiteral "@separatorcolor";
        padding = 1;
      };

      "textbox" = {
        highlight = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };

      "listview" = {
        border-color = mkLiteral "@separatorcolor";
        scrollbar = mkLiteral "@scrollbar";
      };

      "element" = {
        border = 0;
        padding = 2;
      };

      "element.normal.normal" = {
        background-color = mkLiteral "@normal-background";
        text-color = mkLiteral "@normal-foreground";
      };

      "element.normal.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-foreground";
      };

      "element.normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-foreground";
      };

      "element.selected.normal" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
      };

      "element.selected.urgent" = {
        background-color = mkLiteral "@selected-urgent-background";
        text-color = mkLiteral "@selected-urgent-foreground";
      };

      "element.selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color = mkLiteral "@selected-active-foreground";
      };

      "element.alternate.normal" = {
        background-color = mkLiteral "@alternate-normal-background";
        text-color = mkLiteral "@alternate-normal-foreground";
      };

      "element.alternate.urgent" = {
        background-color = mkLiteral "@alternate-urgent-background";
        text-color = mkLiteral "@alternate-urgent-foreground";
      };

      "element.alternate.active" = {
        background-color = mkLiteral "@alternate-active-background";
        text-color = mkLiteral "@alternate-active-foreground";
      };

      "scrollbar" = {
        width = 4;
        border = 0;
        handle-color = mkLiteral "@scrollbar-handle";
        handle-width = 8;
        padding = 0;
      };

      "mode-switcher" = {
        border = mkLiteral "2px 0 0";
        border-color = mkLiteral "@separatorcolor";
      };

      "inputbar" = {
        spacing = 0;
        text-color = mkLiteral "@normal-foreground";
        padding = 2;
        children = map mkLiteral [ "prompt" "textbox-prompt-sep" "entry" "case-indicator" ];
      };

      "case-indicator, entry, prompt, button" = {
        spacing = 0;
        text-color = mkLiteral "@normal-foreground";
      };

      "button.selected" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
      };

      "textbox-prompt-sep" = {
        expand = false;
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral "@normal-foreground";
      };

      "element-text, element-icon" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
    };
  };
}