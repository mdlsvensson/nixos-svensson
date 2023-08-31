{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Xorg | https://nixos.wiki/wiki/XMonad
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.mouse.accelProfile = "flat";
    windowManager.i3.enable = true;
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
  sound.enable = true;  # Setting to false may fix pipewire if no sound
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
    # You can pick specific nerdfonts with this override
    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
  ];

  environment.systemPackages = with pkgs; [
    xclip                 # Command line interface to the X11 clipboard
    alsa-utils            # A lot of utils for alsa
    maim                  # Screenshots
    usbutils              # USB-related utilities
    pavucontrol           # PulseAudio GUI, works with pipewire with pulse server emulation
    nsxiv                 # Simple X Image Viewer
    gnumake               # make
    dotnet-sdk_7          # .NET
    notify-desktop        # Notifications
    pcmanfm               # File Manager
    libsForQt5.ark        # Archive Manager
    networkmanager_dmenu  # NM for dmenu
    rustc                 # Rust
    cargo                 # Rust
  ];

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Vulkan
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
}
