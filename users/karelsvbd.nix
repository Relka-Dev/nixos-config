{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.users.karelsvbd = {
    isNormalUser = true;
    description = "Karel Vilém Svoboda";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.karelsvbd =
    {
      pkgs,
      lib,
      firefox-addons,
      ...
    }:
    {
      imports = [ ./common.nix ];

      xdg.mimeApps.defaultApplications = {
        "application/pdf" = "zen-browser";
      };

      home.file.".face.icon".source = ../avatars/karelsvbd.png;
    };
}
