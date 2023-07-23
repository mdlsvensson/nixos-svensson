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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # ===============================================================================
  # ================ Common for both server and desktop/laptop ====================
  # ===  SYSTEM  === allowUnfree means software that has a restricitve lisence. ===
  # === PACKAGES === it's not necessarily software that costs money. ==============
  # ================ vscode is considered "unfree", vscodium is not. ==============
  # ===============================================================================
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
