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

      home.file.".face.icon".source = "/etc/nixos/avatars/karelsvbd.png";

      programs.vscode.profiles.default.userSettings = {
        "workbench.colorTheme" = "GitHub Dark Dimmed";
      };
    };
}
