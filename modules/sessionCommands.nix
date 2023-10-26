{
  services.xserver.displayManager.sessionCommands = ''
    xrandr --output DisplayPort-0 --mode 1920x1080 --pos 1920x0 --rotate left --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x288 --rotate normal
    feh --bg-tile ~/Pictures/wallpaper.png
  '';
}