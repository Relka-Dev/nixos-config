{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/maintenance.nix
    ./users/veks.nix
    ./users/karelsvbd.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;

  # Packages globaux
  environment.systemPackages = with pkgs; [
    wget
    firefox
    steam
    vscode
    jetbrains.idea
    protonplus
    fastfetch
    krita
    qbittorrent-enhanced
    vesktop
    gimp2-with-plugins
    spotify
    mpv
    neovim
    ripgrep
    fd
  ];

  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
