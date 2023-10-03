{ pkgs, ... }:
  let
    onLogin = ''
      xrandr --output DisplayPort-0 --mode 1920x1080 --pos 1920x0 --rotate left --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x288 --rotate normal
      feh --bg-tile ~/Pictures/wallpaper.png
    '';
  in
{
  # https://nixos.wiki/wiki/Xorg | https://nixos.wiki/wiki/XMonad
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.mouse.accelProfile = "flat";
    windowManager = {
      i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3a
        ];
      };
    };
    displayManager = {
      lightdm = {
        enable = true;
        greeters = {
          gtk = {
            enable = true;
            theme = with pkgs; {
              package = ayu-theme-gtk;
              name = "Ayu-Dark";
            };
          };
        };
        background = "#212731";
      };
      defaultSession = "none+i3";
      sessionCommands = onLogin;
    };
  };

  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';

  # https://nixos.wiki/wiki/Picom
  services.picom = {
    enable = true;
    vSync = true;
    shadow = false;
  };

  # https://nixos.wiki/wiki/PipeWire
  sound.enable = true;  # Setting to false may be a fix
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # https://nixos.wiki/wiki/Fonts | https://github.com/ryanoasis/nerd-fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
  ];

  environment.systemPackages = with pkgs; [
    xclip                 # Command line interface to the X11 clipboard
    alsa-utils            # A lot of utils for alsa
    maim                  # Screenshots
    usbutils              # USB-related utilities
    pavucontrol           # PulseAudio GUI, works with pipewire with pulse server emulation
    feh                   # Image viewer
    notify-desktop        # Notifications
    pcmanfm               # File Manager
    libsForQt5.ark        # Archive Manager
    xmobar                # Status bar
  ];

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Vulkan
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
