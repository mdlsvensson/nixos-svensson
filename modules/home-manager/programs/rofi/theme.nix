{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  "*" = {
    scrollbar = false;

    background = mkLiteral colorScheme.base00;

    bg = mkLiteral "#272D38";
    bg-dark = mkLiteral "#0F1419";
    bg-highlight = mkLiteral "#E6E1CF";
    fg = mkLiteral "#E6E1CF";
    fg-dark = mkLiteral "#0F1419";
    red = mkLiteral "#F07178";
    yellow = mkLiteral "#FFB454";
    orange = mkLiteral "#FF8F40";
    gray = mkLiteral "#3E4B59";
  };

}

  #  background-color = mkLiteral "#000000";
  #   foreground-color = mkLiteral "rgba ( 250, 251, 252, 100 % )";
  #   border-color = mkLiteral "#FFFFFF";
  #   width = 512;
  # };

  # "#inputbar" = {
  #   children = map mkLiteral [ "prompt" "entry" ];
  # };

  # "#textbox-prompt-colon" = {
  #   expand = false;
  #   str = ":";
  #   margin = mkLiteral "0px 0.3em 0em 0em";
  #   text-color = mkLiteral "@foreground-color";
  # };