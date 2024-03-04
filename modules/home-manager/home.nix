{ inputs, config, pkgs, ... }:
{
  home = {
    username = "mdlsvensson";
    homeDirectory = "/home/mdlsvensson";

    file =
      let
        lain = inputs.awesome-lain;
        freedesktop = inputs.awesome-freedesktop;
        copycats = inputs.awesome-copycats;
      in {
      # i3wm
      ".config/i3".source = ../../dots/i3;
      # mpv
      ".config/mpv".source = ../../dots/mpv;
      # awesome
      ".config/awesome/lain".source = "${lain}";
      ".config/awesome/freedesktop".source = "${freedesktop}";
      ".config/awesome/themes".source = "${copycats}/themes";
      ".config/awesome/rc.lua".source = ../../dots/awesome/rc.lua;
      ".config/awesome/wall.png".source = ../../dots/awesome/wall.png;
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