{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.plasma = {
    enable = true;
    workspace = {
      wallpaper = "/etc/nixos/wallpapers/black-gray.png";
      colorScheme = "BreezeDark";
    };

    configFile = {
      "kdeglobals"."Colors:Window"."AccentColor" = "255,0,0";
      "kdeglobals"."Colors:View"."AccentColor" = "255,0,0";
      "kdeglobals"."Colors:Button"."AccentColor" = "255,0,0";
      "kdeglobals"."Colors:Selection"."AccentColor" = "255,0,0";
      "kdeglobals"."General"."AccentColor" = "255,0,0";
    };

    panels = [
      {
        location = "top";
        screen = "all";
        floating = false;
        hiding = "none";
        height = 38;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
          {
            digitalClock = {
              time = {
                format = "24h";
                showSeconds = "never";
              };
              date.enable = false;
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };

  programs.git = {
    enable = true;
    userName = "Relka-Dev";
    userEmail = "relka.dev@gmail.com";
  };

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      identityFile = "~/.ssh/id_ed25519";
      user = "git";
    };
  };
}
