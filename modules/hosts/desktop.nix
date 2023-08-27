{ ... }:
{
  imports = [
    ./common/common-configuration.nix
    ./hw/hw-desktop.nix  # nixos-generate-config --show-hardware-config > hw-desktop.nix
  ];
  
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  services.autorandr.enable = true;
}