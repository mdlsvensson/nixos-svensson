{ ... }:
{
  imports = [
    ./common/common-configuration.nix
    ./hw/hw-laptop.nix  # nixos-generate-config --show-hardware-config > hw-laptop.nix
  ];

  hardware.acpilight.enable = true;
  services.xserver.libinput.touchpad.accelProfile = "flat";
}
