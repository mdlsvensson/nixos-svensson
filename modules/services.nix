{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us,se";
        options = "grp:win_space_toggle";
      };
      libinput.mouse.accelProfile = "flat";
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
      windowManager.i3 = {
        enable = true;
        extraPackages = [ pkgs.i3a ];
      };
      displayManager = {
        lightdm = {
          enable = true;
          greeters = {
            gtk = {
              enable = true;
              theme = with pkgs; {
                package = ayu-theme-gtk;
                name = "Ayu-Dark";
              };
            };
          };
          background = "#212731";
        };
        sessionCommands = ''
          xrandr --output DisplayPort-0 --mode 1920x1080 --pos 1920x0 --rotate left --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x288 --rotate normal
          feh --bg-tile ~/Pictures/wallpaper.png
        '';
      };
    };

    picom = {
      enable = true;
      vSync = true;
      shadow = false;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    gnome.gnome-keyring.enable = true;
  };
}