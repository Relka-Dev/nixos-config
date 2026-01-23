{ config, pkgs, ... }:

{
  users.users.veks = {
    isNormalUser = true;
    description = "Veks";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  home-manager.users.veks = { pkgs, ... }: {
    imports = [ ./common.nix ];

    # Override: thème rouge
    programs.plasma = {
      workspace.colorScheme = "BreezeDark";
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
