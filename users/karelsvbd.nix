{ config, pkgs, lib, ... }:
{
  users.users.karelsvbd = {
    isNormalUser = true;
    description = "Karel Vilém Svoboda";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  home-manager.users.karelsvbd = { pkgs, lib, ... }: {
    imports = [ ./common.nix ];
    
    home.file.".face.icon".source = ../avatars/karelsvbd.png;

    # Override: thème NixOS multicolor (gris anthracite + accents pastels)
    programs.plasma = {
      workspace = {
        colorScheme = "BreezeDark";
        wallpaper = lib.mkForce ../wallpapers/multicolor.png;
      };
      
      configFile = {
        # Couleurs principales - tons gris anthracite
        "kdeglobals"."Colors:Window"."BackgroundNormal" = "45,55,65";
        "kdeglobals"."Colors:Window"."BackgroundAlternate" = "55,68,80";
        "kdeglobals"."Colors:Window"."ForegroundNormal" = "220,225,230";
        "kdeglobals"."Colors:Window"."ForegroundInactive" = "130,145,160";
        
        "kdeglobals"."Colors:View"."BackgroundNormal" = "35,45,55";
        "kdeglobals"."Colors:View"."BackgroundAlternate" = "45,55,68";
        "kdeglobals"."Colors:View"."ForegroundNormal" = "220,225,230";
        "kdeglobals"."Colors:View"."ForegroundInactive" = "130,145,160";
        
        "kdeglobals"."Colors:Button"."BackgroundNormal" = "55,68,82";
        "kdeglobals"."Colors:Button"."BackgroundAlternate" = "48,60,72";
        "kdeglobals"."Colors:Button"."ForegroundNormal" = "220,225,230";
        "kdeglobals"."Colors:Button"."ForegroundInactive" = "130,145,160";
        
        # Couleurs de sélection - turquoise/cyan du logo
        "kdeglobals"."Colors:Selection"."BackgroundNormal" = "126,186,181";
        "kdeglobals"."Colors:Selection"."BackgroundAlternate" = "100,160,155";
        "kdeglobals"."Colors:Selection"."ForegroundNormal" = "25,35,45";
        
        # Accents beige/sable du logo
        "kdeglobals"."Colors:Window"."DecorationFocus" = "228,192,122";
        "kdeglobals"."Colors:Window"."DecorationHover" = "228,192,122";
        "kdeglobals"."Colors:Window"."ForegroundActive" = "228,192,122";
        "kdeglobals"."Colors:Window"."ForegroundLink" = "126,186,181";
        
        "kdeglobals"."Colors:View"."DecorationFocus" = "228,192,122";
        "kdeglobals"."Colors:View"."DecorationHover" = "228,192,122";
        "kdeglobals"."Colors:View"."ForegroundActive" = "228,192,122";
        "kdeglobals"."Colors:View"."ForegroundLink" = "126,186,181";
        
        "kdeglobals"."Colors:Button"."DecorationFocus" = "228,192,122";
        "kdeglobals"."Colors:Button"."DecorationHover" = "228,192,122";
        "kdeglobals"."Colors:Button"."ForegroundActive" = "228,192,122";
        "kdeglobals"."Colors:Button"."ForegroundLink" = "126,186,181";
        
        "kdeglobals"."Colors:Selection"."DecorationFocus" = "228,192,122";
        "kdeglobals"."Colors:Selection"."DecorationHover" = "228,192,122";
        "kdeglobals"."Colors:Selection"."ForegroundActive" = "255,255,255";
        "kdeglobals"."Colors:Selection"."ForegroundLink" = "126,186,181";
        
        # Couleur d'accent générale - beige/or du logo
        "kdeglobals"."General"."AccentColor" = "228,192,122";
      };
    };
  };
}