{
  services = {
    xserver = {
      enable = true;
      layout = "us";
      libinput.mouse.accelProfile = "flat";
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
    };
  };
}