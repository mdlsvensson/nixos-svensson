{ pkgs, ... }:
{
  # The plan is to add a sway config to this flake eventually
  # https://nixos.wiki/wiki/Xorg, https://nixos.wiki/wiki/XMonad
  services.xserver.enable = true;
  services.xserver.layout = "us";                          # Keyboard layout.
  services.xserver.libinput.mouse.accelProfile = "flat";   # Disable mouse acceleration.

  # DESKTOP MANAGER
  services.xserver.desktopManager.xmonad.enable = true;    # Main WM
  services.xserver.desktopManager.xfce.enable = true;      # Fallback DE and available for family members who want to check their email while over for dinner.

  # DISPLAY MANAGER
  services.xserver.displayManager.lightdm.enable = true;   # LightDM Display Manager (the login screen, aka "greeter").
  services.xserver.displayManager.defaultSession = "xfce"; # Session can be set in the top-right at login.

  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';                                                      # Disable all "monitor turn off", "screen-savery"-type behavior.

  # https://nixos.wiki/wiki/Picom
  services.picom.enable = true;
  services.picom.vSync = true;

  # This is mostly default sound config that comes with the graphical installer
  # With PulseAudio server emulation on you can use pavucontrol
  # Experiment with the settings there if you still have no sound
  # https://nixos.wiki/wiki/PipeWire 
  sound.enable = true; # If you get no sound with pipewire try setting this to false and rebuilding.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true; # Pipewire needs realtimeKit enabled.
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true; # 32bit support if you run 64bit system.
  services.pipewire.pulse.enable = true;      # Pulse server emulation. Can use pulse tools and gui.

  # You can pick specific nerdfonts with this override
  # https://nixos.wiki/wiki/Fonts === https://github.com/ryanoasis/nerd-fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
  ];

  # Common packages for desktop-laptop
  environment.systemPackages = with pkgs; [
    xclip
    alsa-utils
    maim
    usbutils
    pavucontrol
    nsxiv
  ];

  # Vulcan
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
