{ config, pkgs, ... }:
{
  users.users.veks = {
    isNormalUser = true;
    description = "Veks";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.veks =
    { pkgs, firefox-addons, ... }:
    {
      imports = [ ./common.nix ];

      home.file.".face.icon".source = ../avatars/veks.png;
    };
}
