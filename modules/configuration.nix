{ inputs, config, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # "video" group for xbacklight
  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users.${config.setupConfig.user.username} = {
    home = config.setupConfig.user.homeDirectory;
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = "nix-command flakes";
  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;

  # Common packages for server-desktop-laptop
  # unfree packages = restrictively lisenced
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    file
    vim
    neofetch
    killall
    unzip
    zip
    inxi
    htop
    fd
    gnutar
    zenith
    git
  ];

  sudo.extraConfig = "Defaults env_reset,pwfeedback"; # Shows passwords characters as asterisks

  networking.hostName = config.setupConfig.host;
  networking.networkmanager.enable = true; # Enable network manager for all hosts

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
