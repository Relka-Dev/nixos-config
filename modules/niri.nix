{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    waybar
    fuzzel
    swaybg
    swaylock
    mako
  ];
}
