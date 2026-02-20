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
    { pkgs, ... }:
    {
      imports = [ ./common.nix ];

      home.file.".face.icon".source = ../avatars/veks.png;

      # Thème rouge/noir avec contrastes
      programs.plasma = {
        workspace = {
          colorScheme = "BreezeDark";
          wallpaper = "/etc/nixos/wallpapers/black-gray.png";
        };

        configFile = {
          "kdeglobals"."Colors:Window"."BackgroundNormal" = "15,15,15";
          "kdeglobals"."Colors:Window"."BackgroundAlternate" = "25,25,25";
          "kdeglobals"."Colors:Window"."ForegroundNormal" = "220,220,220";
          "kdeglobals"."Colors:Window"."ForegroundInactive" = "100,100,100";

          "kdeglobals"."Colors:View"."BackgroundNormal" = "10,10,10";
          "kdeglobals"."Colors:View"."BackgroundAlternate" = "20,20,20";
          "kdeglobals"."Colors:View"."ForegroundNormal" = "220,220,220";
          "kdeglobals"."Colors:View"."ForegroundInactive" = "100,100,100";

          "kdeglobals"."Colors:Button"."BackgroundNormal" = "30,30,30";
          "kdeglobals"."Colors:Button"."BackgroundAlternate" = "25,25,25";
          "kdeglobals"."Colors:Button"."ForegroundNormal" = "220,220,220";
          "kdeglobals"."Colors:Button"."ForegroundInactive" = "100,100,100";

          "kdeglobals"."Colors:Selection"."BackgroundNormal" = "180,20,20";
          "kdeglobals"."Colors:Selection"."BackgroundAlternate" = "140,15,15";
          "kdeglobals"."Colors:Selection"."ForegroundNormal" = "255,255,255";

          "kdeglobals"."Colors:Window"."DecorationFocus" = "220,50,50";
          "kdeglobals"."Colors:Window"."DecorationHover" = "255,80,80";
          "kdeglobals"."Colors:Window"."ForegroundActive" = "255,100,100";
          "kdeglobals"."Colors:Window"."ForegroundLink" = "255,70,70";

          "kdeglobals"."Colors:View"."DecorationFocus" = "220,50,50";
          "kdeglobals"."Colors:View"."DecorationHover" = "255,80,80";
          "kdeglobals"."Colors:View"."ForegroundActive" = "255,100,100";
          "kdeglobals"."Colors:View"."ForegroundLink" = "255,70,70";

          "kdeglobals"."Colors:Button"."DecorationFocus" = "220,50,50";
          "kdeglobals"."Colors:Button"."DecorationHover" = "255,80,80";
          "kdeglobals"."Colors:Button"."ForegroundActive" = "255,100,100";
          "kdeglobals"."Colors:Button"."ForegroundLink" = "255,70,70";

          "kdeglobals"."Colors:Selection"."DecorationFocus" = "255,60,60";
          "kdeglobals"."Colors:Selection"."DecorationHover" = "255,90,90";
          "kdeglobals"."Colors:Selection"."ForegroundActive" = "255,255,255";
          "kdeglobals"."Colors:Selection"."ForegroundLink" = "255,120,120";

          "kdeglobals"."General"."AccentColor" = "220,50,50";
        };
      };

      programs.vscode.profiles.default.userSettings = {
        "workbench.colorTheme" = "GitHub Dark Default";
      };
    };
}
