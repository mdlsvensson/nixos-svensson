{ ... }:
{
  imports = [ ./common/common-configuration.nix ];
  
  initrd.kernelModules = [ "amdgpu" ];
  xserver.videoDrivers = [ "amdgpu" ];
}