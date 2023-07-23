{
  networking.hostName = "laptop";

  # BACKLIGHT
  hardware.acpilight.enable = true;

  # TOUCHPAD
  services.xserver.libinput.touchpad.accelProfile = "flat";
}
