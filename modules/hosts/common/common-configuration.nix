{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Xorg | https://nixos.wiki/wiki/XMonad
  services.xserver.enable = true;
  services.xserver.layout = "us";                          # Keyboard layout
  services.xserver.libinput.mouse.accelProfile = "flat";   # Disable mouse acceleration
  services.xserver.windowManager.xmonad.enable = true;     # Main
  services.xserver.desktopManager.xfce.enable = true;      # Fallback
  services.xserver.displayManager.lightdm.enable = true;   # Login ("greeter")
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

  # With PulseAudio server emulation on you can use pavucontrol
  # Experiment with the settings there if you still have no sound
  # https://nixos.wiki/wiki/PipeWire 
  sound.enable = true;                        # Setting to false can fix pipewire sound if you had this enabled before
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true; # 32bit support if you run 64bit system
  services.pipewire.pulse.enable = true;      # Pulse server emulation

  # https://nixos.wiki/wiki/Fonts | https://github.com/ryanoasis/nerd-fonts
  # You can pick specific nerdfonts with this override
  fonts.fonts = with pkgs; [
    noto-fonts
    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
  ];

  # Common packages for desktop-laptop
  environment.systemPackages = with pkgs; [
    xclip       # Command line interface to the X11 clipboard
    alsa-utils  # Alot of utils for alsa
    maim        # Screenshots
    usbutils    # USB-related utilities
    pavucontrol # PulseAudio GUI, works with pipewire with pulse server emulation
    nsxiv       # Simple X Image Viewer
  ];

  # Vulkan
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
