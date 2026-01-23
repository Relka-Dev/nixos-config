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

    # Override: thème Leather Gold (noir/brun cuir/doré)
    programs.plasma = {
      workspace.colorScheme = "BreezeDark";
      
      configFile = {
        # Couleurs principales - tons bruns/cuir
        "kdeglobals"."Colors:Window"."BackgroundNormal" = "25,22,20";
        "kdeglobals"."Colors:Window"."BackgroundAlternate" = "30,27,24";
        "kdeglobals"."Colors:Window"."ForegroundNormal" = "230,220,205";
        "kdeglobals"."Colors:Window"."ForegroundInactive" = "120,105,95";
        
        "kdeglobals"."Colors:View"."BackgroundNormal" = "18,16,14";
        "kdeglobals"."Colors:View"."BackgroundAlternate" = "28,25,23";
        "kdeglobals"."Colors:View"."ForegroundNormal" = "230,220,205";
        "kdeglobals"."Colors:View"."ForegroundInactive" = "120,105,95";
        
        "kdeglobals"."Colors:Button"."BackgroundNormal" = "35,30,27";
        "kdeglobals"."Colors:Button"."BackgroundAlternate" = "28,25,23";
        "kdeglobals"."Colors:Button"."ForegroundNormal" = "230,220,205";
        "kdeglobals"."Colors:Button"."ForegroundInactive" = "120,105,95";
        
        # Couleurs de sélection - tons brun moyen
        "kdeglobals"."Colors:Selection"."BackgroundNormal" = "120,90,60";
        "kdeglobals"."Colors:Selection"."BackgroundAlternate" = "80,60,40";
        "kdeglobals"."Colors:Selection"."ForegroundNormal" = "255,250,240";
        
        # Accents dorés
        "kdeglobals"."Colors:Window"."DecorationFocus" = "212,175,55";
        "kdeglobals"."Colors:Window"."DecorationHover" = "212,175,55";
        "kdeglobals"."Colors:Window"."ForegroundActive" = "212,175,55";
        "kdeglobals"."Colors:Window"."ForegroundLink" = "212,175,55";
        
        "kdeglobals"."Colors:View"."DecorationFocus" = "212,175,55";
        "kdeglobals"."Colors:View"."DecorationHover" = "212,175,55";
        "kdeglobals"."Colors:View"."ForegroundActive" = "212,175,55";
        "kdeglobals"."Colors:View"."ForegroundLink" = "212,175,55";
        
        "kdeglobals"."Colors:Button"."DecorationFocus" = "212,175,55";
        "kdeglobals"."Colors:Button"."DecorationHover" = "212,175,55";
        "kdeglobals"."Colors:Button"."ForegroundActive" = "212,175,55";
        "kdeglobals"."Colors:Button"."ForegroundLink" = "212,175,55";
        
        "kdeglobals"."Colors:Selection"."DecorationFocus" = "212,175,55";
        "kdeglobals"."Colors:Selection"."DecorationHover" = "212,175,55";
        "kdeglobals"."Colors:Selection"."ForegroundActive" = "255,255,255";
        "kdeglobals"."Colors:Selection"."ForegroundLink" = "212,175,55";
        
        # Couleur d'accent générale
        "kdeglobals"."General"."AccentColor" = "212,175,55";
      };
    };
  };
}
