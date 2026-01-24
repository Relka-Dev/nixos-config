{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  # Config Plasma partagée (panels, widgets, etc.)
  programs.plasma = {
    enable = true;
    
    configFile = {
      "ksmserverrc"."General"."loginMode" = "emptySession";
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
    settings = {
      user = {
        userName = "Relka-Dev";
        userEmail = "relka.dev@gmail.com";
      };
    };
  };

  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    matchBlocks."github.com" = {
      identityFile = "~/.ssh/id_ed25519";
      user = "git";
    };
  };
}
