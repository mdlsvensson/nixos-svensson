{
  services = {
    redshift = {
      enable = true;
      temperature = {
        day = 6500;
        night = 5000;
      };
      latitude = "59.32";
      longitude = "18.06";
    };

    unclutter.enable = true;
  };
}