{ pkgs, ... }: {
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = [ pkgs.i3a ];
  };
}