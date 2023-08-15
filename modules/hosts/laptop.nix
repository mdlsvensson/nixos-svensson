{ inputs, ... }:
{
  imports = [ ./common/common-configuration.nix ];

  # BACKLIGHT
  hardware.acpilight.enable = true;
  # TOUCHPAD
  services.xserver.libinput.touchpad.accelProfile = "flat";
}
