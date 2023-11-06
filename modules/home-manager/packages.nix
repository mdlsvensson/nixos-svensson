{ pkgs, ... }: {
  home.packages = with pkgs; [
    godot_4                 # Godot Engine
    blender-hip             # Blender
    wings                   # Wings3D
    qbittorrent             # Torrent client
    gimp                    # Image editor
    tor-browser-bundle-bin  # Tor Browser
    r2mod_cli               # Risk of Rain 2 mod manager
    r2modman                # Risk of Rain 2 mod manager
    rofi-screenshot
    rofi-power-menu
    lutris
    vlc
    wineWowPackages.stable
    winetricks
    mono
    gnome.zenity
    bottles
  ];
}