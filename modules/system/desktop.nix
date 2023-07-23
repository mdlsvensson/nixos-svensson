{
  networking.hostName = "desktop";

  # KERNEL MODULES
  boot.initrd.kernelModules = [ "amdgpu" ];

  # VIDEO DRIVERS
  services.xserver.videoDrivers = [ "amdgpu" ];
}