{ config, ... }:
{
  xdg = with config.home; {
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${homeDirectory}/Documents";
      download = "${homeDirectory}/Downloads";
      pictures = "${homeDirectory}/Pictures";
      templates = "${homeDirectory}/Templates";
      desktop = null;
      music = null;
      publicShare = null;
      videos = null;
      extraConfig = {
        XDG_REPO_PATH = "${homeDirectory}/Repo";
        XDG_GAMES_PATH = "${homeDirectory}/Games";
      };
    };

    mimeApps = {
      enable = true;
        defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "text/xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "inode/directory" = [ "pcmanfm.desktop" ];
        "image/png" = [ "feh.desktop" ];
        "image/jpeg" = [ "feh.desktop" ];
      };
    };
  };
}