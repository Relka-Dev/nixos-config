{ config, pkgs, ... }:

{
  users.users.veks = {
    isNormalUser = true;
    description = "Veks";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  home-manager.users.veks = import ./common.nix;
}
