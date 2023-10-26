{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Fonts | https://github.com/ryanoasis/nerd-fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "JetBrainsMono"
        "Noto"
      ];
    })
  ];
}