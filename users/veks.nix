{ config, pkgs, ... }:

{
  users.users.veks = {
    isNormalUser = true;
    description = "Veks";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  home-manager.users.veks = { pkgs, ... }: {
    imports = [ ./common.nix ];

    home.file.".face.icon".source = ../avatars/veks.png;

    # Override: thème rouge
    programs.plasma = {
      
      workspace = {
        colorScheme = "BreezeDark";
        wallpaper = "/etc/nixos/wallpapers/black-gray.png";
      };


      configFile = {
        "kdeglobals"."Colors:Window"."AccentColor" = "255,0,0";
        "kdeglobals"."Colors:View"."AccentColor" = "255,0,0";
        "kdeglobals"."Colors:Button"."AccentColor" = "255,0,0";
        "kdeglobals"."Colors:Selection"."AccentColor" = "255,0,0";
        "kdeglobals"."General"."AccentColor" = "255,0,0";
      };
    };
  };
}
