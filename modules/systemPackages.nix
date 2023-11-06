{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
    git
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