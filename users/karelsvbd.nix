{ config, pkgs, ... }:

{
  users.users.karelsvbd = {
    isNormalUser = true;
    description = "Karel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  home-manager.users.karelsvbd = import ./common.nix;
}
