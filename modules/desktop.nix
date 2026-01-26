{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
    settings.General.background = "/etc/nixos/wallpapers/brown.jpg";
  };
  
  services.desktopManager.plasma6.enable = true;
  
  # Exclure les apps KDE inutiles
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa         
    okular        
    khelpcenter
  ];
}