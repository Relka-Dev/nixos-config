{ config, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.networkmanager.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "fr_CH";
  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  services.printing.enable = true;

  services.power-profiles-daemon.enable = true;

  # Règle udev pour changer de profil automatiquement
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
    SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';
}
