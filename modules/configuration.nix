{ inputs, config, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users.${config.setupConfig.user.username} = {
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
  networking.networkmanager.enable = true;

  system.stateVersion = "23.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
