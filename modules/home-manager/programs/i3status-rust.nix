{
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars.top = {
    blocks = [
      {
        block = "memory";
        format = "  $icon$mem_used.eng";
      }
      {
        block = "cpu";
        interval = 1;
        format = "  $icon$utilization ";
      }
      { block = "sound"; }
      {
        block = "time";
        format = {
          short = " $timestamp.datetime(f:'%a - %R')  ";
          full = " $timestamp.datetime(f:'%A, %b %d - %R')  ";
        };
      }
    ];
    settings.theme =  {
      theme = "solarized-dark";
      overrides = {
        idle_bg = "#BFBDB6";
        idle_fg = "#0F1419";
        separator = "";
      };
    };
    icons = "awesome4";
  };
}
