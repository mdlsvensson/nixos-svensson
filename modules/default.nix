{ ... }: {
  imports = [
    ./systemPackages.nix
    ./xserver.nix
    ./sessionCommands.nix
    ./windowManager.nix
    ./displayManager.nix
    ./picom.nix
    ./pipewire.nix
    ./fonts.nix
    ./steam.nix
  ];

  # https://nixos.wiki/wiki/Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users."mdlsvensson".isNormalUser = true;
  users.users."mdlsvensson".extraGroups = [
    "networkmanager"
    "wheel"
    "video"
  ];

  # https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = "nix-command flakes";
  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";

  networking.networkmanager.enable = true;

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  system.stateVersion = "23.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}