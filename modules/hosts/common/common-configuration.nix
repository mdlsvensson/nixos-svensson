{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Xorg | https://nixos.wiki/wiki/XMonad
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.libinput.mouse.accelProfile = "flat";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "xfce";

  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';

  # https://nixos.wiki/wiki/Picom
  services.picom.enable = true;
  services.picom.vSync = true;

  # https://nixos.wiki/wiki/PipeWire 
  sound.enable = true;                        # Setting to false may fix pipewire if no sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;      # Pulse server emulation

  # https://nixos.wiki/wiki/Fonts | https://github.com/ryanoasis/nerd-fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    # You can pick specific nerdfonts with this override
    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
  ];

  environment.systemPackages = with pkgs; [
    xclip       # Command line interface to the X11 clipboard
    alsa-utils  # A lot of utils for alsa
    maim        # Screenshots
    usbutils    # USB-related utilities
    pavucontrol # PulseAudio GUI, works with pipewire with pulse server emulation
    nsxiv       # Simple X Image Viewer
  ];

  # Vulkan
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
