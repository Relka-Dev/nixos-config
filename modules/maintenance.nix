{ config, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
    randomizedDelaySec = "45min";
    persistent = true;
    flake = "/etc/nixos";
    flags = [
      "--no-write-lock-file"
      "-L"
    ];
  };

  systemd.services.nixos-upgrade = {
    environment = {
      GIT_CONFIG_GLOBAL = "/dev/null";
      GIT_CONFIG_SYSTEM = "/dev/null";
    };
    serviceConfig = {
      Environment = "GIT_CEILING_DIRECTORIES=/";
    };
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