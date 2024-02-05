{ ... }:
{
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "usbhid.mousepoll=8" ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}