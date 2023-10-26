{ pkgs, ... }: {
  services.xserver.displayManager.lightdm = {
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
}