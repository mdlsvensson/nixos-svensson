{ config, pkgs, ... }:
{
  imports = [ 
      ./hardware-configuration.nix
      ./hosts/common-configuration.nix
    ];

  # ==============================================================
  # ===  BOOT  === Default nix bootloader configuration. =========
  # === LOADER === Kernel modules are added in /hosts modules. ===
  # ==============================================================
  # === https://nixos.wiki/wiki/Bootloader =======================
  # ==============================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ============================================================================
  # ===      USER      === "wheel" group provides access to sudo. ==============
  # ===   MANAGEMENT   === "video" group gives access to xbacklight. ===========
  # ====================== "networkmanager" group gives access to nmcli.  ======
  # ============================================================================
  # === https://nixos.org/manual/nixos/stable/index.html#sec-user-management ===
  # ============================================================================
  users.users.mdlsvensson = {
    isNormalUser = true;
    description = "Wilmer Lindau";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
  };

  nix = {
    # NIX SETTINGS FROM https://github.com/Misterio77/nix-starter-configs
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # ENABLE FLAKES
      experimental-features = "nix-command flakes";
      # NIX-STORE OPTIMIZATION https://nixos.wiki/wiki/Storage_optimization
      auto-optimise-store = true;
    };
  };

  # ===============================================================================
  # ================ Common for both server and desktop/laptop ====================
  # ===  SYSTEM  === allowUnfree means software that has a restricitve lisence. ===
  # === PACKAGES === it's not necessarily software that costs money. ==============
  # ================ vscode is considered "unfree", vscodium is not. ==============
  # ===============================================================================
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

  # PASSWORD FEEDBACK 
  sudo.extraConfig = "Defaults env_reset,pwfeedback"; # Shows typed characters of your password as asterisks

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
