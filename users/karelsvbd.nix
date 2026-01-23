{ config, pkgs, ... }:

{
  users.users.karelsvbd = {
    isNormalUser = true;
    description = "Karel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  home-manager.users.karelsvbd = { pkgs, ... }: {
    imports = [ ./common.nix ];

    home.file.".face.icon".source = "/etc/nixos/avatars/veks.png";

    # Override: thème inspiré montre Fossil (brun chocolat/cuir + or champagne)
    programs.plasma = {
     workspace = {
      colorScheme = "BreezeDark";
      wallpaper = "/etc/nixos/wallpapers/multicolor.png";
      };
      
      configFile = {
        # Couleurs principales - tons chocolat/brun profond
        "kdeglobals"."Colors:Window"."BackgroundNormal" = "28,22,16";
        "kdeglobals"."Colors:Window"."BackgroundAlternate" = "35,28,20";
        "kdeglobals"."Colors:Window"."ForegroundNormal" = "212,197,176";
        "kdeglobals"."Colors:Window"."ForegroundInactive" = "120,100,80";
        
        "kdeglobals"."Colors:View"."BackgroundNormal" = "20,16,11";
        "kdeglobals"."Colors:View"."BackgroundAlternate" = "30,24,18";
        "kdeglobals"."Colors:View"."ForegroundNormal" = "212,197,176";
        "kdeglobals"."Colors:View"."ForegroundInactive" = "120,100,80";
        
        "kdeglobals"."Colors:Button"."BackgroundNormal" = "40,32,24";
        "kdeglobals"."Colors:Button"."BackgroundAlternate" = "32,26,19";
        "kdeglobals"."Colors:Button"."ForegroundNormal" = "212,197,176";
        "kdeglobals"."Colors:Button"."ForegroundInactive" = "120,100,80";
        
        # Couleurs de sélection - brun cuir chaud
        "kdeglobals"."Colors:Selection"."BackgroundNormal" = "139,111,71";
        "kdeglobals"."Colors:Selection"."BackgroundAlternate" = "100,80,50";
        "kdeglobals"."Colors:Selection"."ForegroundNormal" = "255,250,245";
        
        # Accents or champagne/rose gold
        "kdeglobals"."Colors:Window"."DecorationFocus" = "201,168,118";
        "kdeglobals"."Colors:Window"."DecorationHover" = "201,168,118";
        "kdeglobals"."Colors:Window"."ForegroundActive" = "201,168,118";
        "kdeglobals"."Colors:Window"."ForegroundLink" = "201,168,118";
        
        "kdeglobals"."Colors:View"."DecorationFocus" = "201,168,118";
        "kdeglobals"."Colors:View"."DecorationHover" = "201,168,118";
        "kdeglobals"."Colors:View"."ForegroundActive" = "201,168,118";
        "kdeglobals"."Colors:View"."ForegroundLink" = "201,168,118";
        
        "kdeglobals"."Colors:Button"."DecorationFocus" = "201,168,118";
        "kdeglobals"."Colors:Button"."DecorationHover" = "201,168,118";
        "kdeglobals"."Colors:Button"."ForegroundActive" = "201,168,118";
        "kdeglobals"."Colors:Button"."ForegroundLink" = "201,168,118";
        
        "kdeglobals"."Colors:Selection"."DecorationFocus" = "201,168,118";
        "kdeglobals"."Colors:Selection"."DecorationHover" = "201,168,118";
        "kdeglobals"."Colors:Selection"."ForegroundActive" = "255,255,255";
        "kdeglobals"."Colors:Selection"."ForegroundLink" = "201,168,118";
        
        # Couleur d'accent générale - or champagne
        "kdeglobals"."General"."AccentColor" = "201,168,118";
      };
    };
  };
}
