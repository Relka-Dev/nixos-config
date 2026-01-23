{ config, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
    randomizedDelaySec = "45min";
    persistent = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
