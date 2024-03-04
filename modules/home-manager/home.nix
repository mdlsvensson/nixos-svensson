{ config, pkgs, ... }:
{
  home = {
    username = "mdlsvensson";
    homeDirectory = "/home/mdlsvensson";

    file = {
      # wallpaper
      "Pictures/wallpaper.png".source = ../../wallpaper.png;
      # i3wm
      ".config/i3".source = ../../dots/i3;
      # mpv
      ".config/mpv".source = ../../dots/mpv;
      # awesome
      ".config/awesome".source = ../../dots/awesome;
    };

    # https://github.com/nix-community/home-manager/issues/1800 (workaround)
    activation.boforeCheckLinkTargets = {
      after = [];
      before = [ "checkLinkTargets" ];
      data = ''
        userDir=/home/mdlsvensson/.config/Code/User
        rm -rf $userDir/settings.json
      '';
    };
    activation.afterWriteBoundary = {
      after = [ "writeBoundary" ];
      before = [];
      data = ''
        userDir=/home/mdlsvensson/.config/Code/User
        rm -rf $userDir/settings.json
        cat \
          ${(pkgs.formats.json {}).generate "blabla"
            config.programs.vscode.userSettings} \
          > $userDir/settings.json
      '';
    };
  };
}