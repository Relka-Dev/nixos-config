{ config, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "fr_CH";
  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  services.printing.enable = true;
}
