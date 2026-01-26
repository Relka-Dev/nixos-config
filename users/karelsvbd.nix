{ config, pkgs, lib, ... }:
{
  users.users.karelsvbd = {
    isNormalUser = true;
    description = "Karel Vilém Svoboda";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  home-manager.users.karelsvbd = { pkgs, lib, ... }: {
    imports = [ ./common.nix ];
    
    # home.file.".face.icon".source = ../avatars/karelsvbd.png;

    # Thème bleu foncé géométrique
    programs.plasma = {
      workspace = {
        colorScheme = "BreezeDark";
        wallpaper = "/etc/nixos/wallpapers/dark-blue.jpg";
      };
      
      configFile = {
        # Couleurs principales - bleu marine profond
        "kdeglobals"."Colors:Window"."BackgroundNormal" = "30,35,50";
        "kdeglobals"."Colors:Window"."BackgroundAlternate" = "40,45,60";
        "kdeglobals"."Colors:Window"."ForegroundNormal" = "200,210,220";
        "kdeglobals"."Colors:Window"."ForegroundInactive" = "110,120,140";
        
        "kdeglobals"."Colors:View"."BackgroundNormal" = "25,30,45";
        "kdeglobals"."Colors:View"."BackgroundAlternate" = "35,40,55";
        "kdeglobals"."Colors:View"."ForegroundNormal" = "200,210,220";
        "kdeglobals"."Colors:View"."ForegroundInactive" = "110,120,140";
        
        "kdeglobals"."Colors:Button"."BackgroundNormal" = "45,52,70";
        "kdeglobals"."Colors:Button"."BackgroundAlternate" = "38,45,62";
        "kdeglobals"."Colors:Button"."ForegroundNormal" = "200,210,220";
        "kdeglobals"."Colors:Button"."ForegroundInactive" = "110,120,140";
        
        # Couleurs de sélection - bleu clair géométrique
        "kdeglobals"."Colors:Selection"."BackgroundNormal" = "90,110,150";
        "kdeglobals"."Colors:Selection"."BackgroundAlternate" = "70,90,130";
        "kdeglobals"."Colors:Selection"."ForegroundNormal" = "240,245,250";
        
        # Accents - bleu/gris des formes géométriques
        "kdeglobals"."Colors:Window"."DecorationFocus" = "100,120,160";
        "kdeglobals"."Colors:Window"."DecorationHover" = "100,120,160";
        "kdeglobals"."Colors:Window"."ForegroundActive" = "100,120,160";
        "kdeglobals"."Colors:Window"."ForegroundLink" = "120,150,200";
        
        "kdeglobals"."Colors:View"."DecorationFocus" = "100,120,160";
        "kdeglobals"."Colors:View"."DecorationHover" = "100,120,160";
        "kdeglobals"."Colors:View"."ForegroundActive" = "100,120,160";
        "kdeglobals"."Colors:View"."ForegroundLink" = "120,150,200";
        
        "kdeglobals"."Colors:Button"."DecorationFocus" = "100,120,160";
        "kdeglobals"."Colors:Button"."DecorationHover" = "100,120,160";
        "kdeglobals"."Colors:Button"."ForegroundActive" = "100,120,160";
        "kdeglobals"."Colors:Button"."ForegroundLink" = "120,150,200";
        
        "kdeglobals"."Colors:Selection"."DecorationFocus" = "100,120,160";
        "kdeglobals"."Colors:Selection"."DecorationHover" = "100,120,160";
        "kdeglobals"."Colors:Selection"."ForegroundActive" = "240,245,250";
        "kdeglobals"."Colors:Selection"."ForegroundLink" = "120,150,200";
        
        # Couleur d'accent générale - bleu géométrique
        "kdeglobals"."General"."AccentColor" = "100,120,160";
      };
    };
  };
}