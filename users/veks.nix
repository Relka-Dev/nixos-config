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

      programs.vscode.profiles.default.userSettings = {
        "workbench.colorTheme" = "GitHub Dark Default";
      };
    };
}
