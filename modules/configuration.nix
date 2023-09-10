{ config, pkgs, ... }:
{
  # Disable systemd emergency shell
  systemd.enableEmergencyMode = false;

  # https://nixos.wiki/wiki/Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users."mdlsvensson" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = "nix-command flakes";
  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;
  # Common packages for all hosts
  environment.systemPackages = with pkgs; [
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

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback"; # Shows passwords characters as asterisks

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  system.stateVersion = "23.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
