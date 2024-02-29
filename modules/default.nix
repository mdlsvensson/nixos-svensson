{ pkgs, ... }: {
  imports = [
    ./packages.nix
    ./services.nix
    ./steam.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = false;
  };

  sound.enable = true;
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";
  security.rtkit.enable = true;

  users.users."mdlsvensson".isNormalUser = true;
  users.users."mdlsvensson".extraGroups = [
    "networkmanager"
    "wheel"
    "video"
  ];

  nix.settings.experimental-features = "nix-command flakes";
  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;
  nix.settings.trusted-users = [ "root" "mdlsvensson" ];
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "JetBrainsMono"
        "Noto"
      ];
    })
  ];

  programs.dconf.enable = true;

  system.stateVersion = "23.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}