{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    file
    wget
    vim
    neofetch
    killall
    unzip
    zip
    inxi
    htop
    fd
    zenith
    xclip
    alsa-utils
    maim
    usbutils
    pavucontrol
    feh
    notify-desktop
    pcmanfm
    libsForQt5.ark
  ];
}