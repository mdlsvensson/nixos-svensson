{ appimage-run, appimageTools, fetchurl, makeDesktopItem, makeWrapper, stdenv, symlinkJoin, ... }:

let
  name = "ascension-wow";
  version = "130";

  desktopItem = makeDesktopItem {
    name = "${name}";
    exec = "${name}";
    icon = "${name}";
    type = "Application";
    desktopName = "Ascension WoW";
    categories = [ "Games" ];
  };

  src = fetchurl {
    url = "https://download.ascension-patch.com/update/ascension-launcher-130.AppImage";
    name = "ascension-wow.AppImage";
    sha256 = "sha256-jmMOIZr8ob6gkIFtrvSCsXQDagf2gP4GfeGa8g8lzzE=";
  };

  appimageContents = appimageTools.extract { inherit name src; };
in symlinkJoin {
  inherit name;

  paths = [ appimage-run ];
  buildInputs = [ makeWrapper ];

  postBuild = ''
    # rename appimage-run to ascension-wow
    mv $out/bin/appimage-run $out/bin/"${name}"

    # add flags to actually load the ascension-wow appimage
    wrapProgram $out/bin/"${name}" --add-flags "${src}"

    # create icons and desktop item
    mkdir -p $out/share/applications $out/share/icons/hicolor/256x256/apps
    cp -v ${desktopItem}/share/applications/* $out/share/applications
    cp -v ${appimageContents}/usr/share/icons/hicolor/0x0/apps/projectascension.png $out/share/icons/hicolor/256x256/apps/${name}.png
  '';
}