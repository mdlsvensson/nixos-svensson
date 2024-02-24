{ pkgs, ... }: {
  home.packages = with pkgs; [
    godot_4                 # Godot Engine
    blender-hip             # Blender
    qbittorrent             # Torrent client
    gimp                    # Image editor
    discord                 # Discord
    tor-browser-bundle-bin  # Tor Browser
    vlc                     # Media Player
    gnome.zenity            # Desktop Dialogs
    snes9x                  # SNES Emulator
    protontricks            # Winetricks
    lutris
  ];
}