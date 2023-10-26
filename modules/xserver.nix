{
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.libinput.mouse.accelProfile = "flat";
  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';
}