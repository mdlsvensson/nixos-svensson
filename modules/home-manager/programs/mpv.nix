{ pkgs, ... }: {
  enable = true;
  scripts = with pkgs; [
    mpvScripts.webtorrent-mpv-hook
    mpvScripts.uosc
    mpvScripts.thumbfast
    mpvScripts.sponsorblock
    mpvScripts.quality-menu
  ];
}