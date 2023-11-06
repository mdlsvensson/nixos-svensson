{ config, ... }: {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    pictures = "${config.home.homeDirectory}/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    desktop = null;
    music = null;
    publicShare = null;
    videos = null;
    extraConfig = {
      XDG_REPO_PATH = "${config.home.homeDirectory}/Repo";
      XDG_GAMES_PATH = "${config.home.homeDirectory}/Games";
    };
  };
}