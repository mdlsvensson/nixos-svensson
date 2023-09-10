{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Xorg | https://nixos.wiki/wiki/XMonad
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.mouse.accelProfile = "flat";
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        networkmanager_dmenu
      ];
    };
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+i3";
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
    pulse.enable = true;  # Pulse server emulation
  };

  # https://nixos.wiki/wiki/Fonts | https://github.com/ryanoasis/nerd-fonts
  fonts.packages = with pkgs; [
    noto-fonts
    # Specific nerdfont override
    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
  ];

  environment.systemPackages = with pkgs; [
    xclip                 # Command line interface to the X11 clipboard
    alsa-utils            # A lot of utils for alsa
    maim                  # Screenshots
    usbutils              # USB-related utilities
    pavucontrol           # PulseAudio GUI, works with pipewire with pulse server emulation
    nsxiv                 # Simple X Image Viewer
    notify-desktop        # Notifications
    pcmanfm               # File Manager
    libsForQt5.ark        # Archive Manager
  ];

  programs.dconf.enable = true;
  #services.gnome.gnome-keyring.enable = true;

  # Vulkan
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
}
