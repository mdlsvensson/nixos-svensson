{ ... }:
{
  imports = [ ./common/common-configuration.nix ];

  hardware.acpilight.enable = true;
  services.xserver.libinput.touchpad.accelProfile = "flat";
}
