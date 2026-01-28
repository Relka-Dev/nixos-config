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
          {
            name = "org.kde.plasma.kickoff";
            config = {
              "General" = {
                "icon" = "/etc/nixos/icons/nixos.png";
              };
            };
          }
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:systemsettings.desktop"
                "applications:firefox.desktop"
                "applications:vesktop.desktop"
                "applications:spotify.desktop"
              ];
            };
          }
          
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

          "org.kde.plasma.systemmonitor.net"
          "org.kde.plasma.systemmonitor.cpu"

          {
            name = "org.kde.plasma.systemmonitor";
            config = {
              "Appearance" = {
                "chartType" = "org.kde.ksysguard.linechart"; 
                "showText" = true;                           
                "title" = "GPU";
              };
              "Sensors" = {
                "highPrioritySensorIds" = "[\"gpu/all/usage\"]";
                "totalSensors" = "[\"gpu/all/usage\"]";
              };
            };
          }
          "org.kde.plasma.systemtray"
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
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [
        "git"
        "sudo"
        "docker"
        "colored-man-pages"
        "command-not-found"
      ];
    };

    shellAliases = {
      ll = "ls -lah";
      la = "ls -A";
      l = "ls -CF";

      # NixOS stuff
      update = "sudo nixos-rebuild switch";
      test = "sudo nixos-rebuild test";
      rollback = "sudo nixos-rebuild switch --rollback";
      cleanup = "sudo nix-collect-garbage -d";
      generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      # git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gd = "git diff";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Système
      ports = "netstat -tulanp";
      myip = "curl ifconfig.me";

      # Django
      dj = "python manage.py";
      djrun = "python manage.py runserver";
      djmig = "python manage.py migrate";
      djmake = "python manage.py makemigrations";

      # Recherche
      grep = "grep --color=auto";
      fhere = "find . -name";
    };    

    initContent = ''
      export EDITOR=nvim
    '';
  };

}