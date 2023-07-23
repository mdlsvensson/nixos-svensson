{
  # ========================================================================================================
  # === DISPLAY === I stay primarily on X as I, like many, have had bad wayland experiences in the past  ===
  # === SERVER  === But as wayland improves the plan is to add a sway config to this flake eventually    ===
  # ========================================================================================================
  # === https://nixos.wiki/wiki/Xorg === https://nixos.wiki/wiki/XMonad === https://nixos.wiki/wiki/Xfce ===
  # ========================================================================================================
  services.xserver.enable = true;
  services.xserver.layout = "us"; # Keyboard layout
  services.xserver.libinput.mouse.accelProfile = "flat"; # Disable mouse acceleration.
  services.xserver.desktopManager.xmonad.enable = true; # Main WM
  services.xserver.desktopManager.xfce.enable = true; # Fallback DE and available for family members who want to check their email while over for dinner.
  services.xserver.displayManager.lightdm.enable = true; # LightDM Display Manager (the login screen, aka "greeter").
  services.xserver.displayManager.defaultSession = "xfce"; # Session can be set in the top-right while loggin in.

  services.xserver.serverFlagsSection = '' # Disable all "monitor turn off", "screen-savery"-type behavior.
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';

  # =========================================================================
  # === COMPOSITOR === I use picom for the vSync, sorts my screen-tearing ===
  # =========================================================================
  # === https://nixos.wiki/wiki/Picom =======================================
  # =========================================================================
  services.picom.enable = true;
  services.picaom.vSync = true;
}
