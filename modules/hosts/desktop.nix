{ ... }:
{
  imports = [ ./common/common-configuration.nix ];
  
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
}