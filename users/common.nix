{ pkgs, firefox-addons, ... }:
{
  home.stateVersion = "25.05";

  programs.plasma = {
    enable = true;

    kwin = {
      effects = {
        wobblyWindows.enable = false;
        blur.enable = true;
        translucency.enable = false;
        cube.enable = false;
        dimInactive.enable = false;
      };

      virtualDesktops = {
        number = 4;
        rows = 1;
      };
    };

    configFile = {
      "ksmserverrc"."General"."loginMode" = "emptySession";

      "kdeglobals"."KDE"."AnimationDurationFactor" = "0.5";

      "kwinrc"."Compositing"."Enabled" = true;
      "kwinrc"."Compositing"."Backend" = "OpenGL";
      "kwinrc"."Compositing"."GLCore" = true;
      "kwinrc"."Compositing"."LatencyPolicy" = "Low";

      "kwinrc"."Effect-Blur"."BlurStrength" = 3;
      "kwinrc"."Effect-Blur"."NoiseStrength" = 0;

      "kwinrc"."Plugins"."fadeEnabled" = true;
      "kwinrc"."Effect-Fade"."FadeInTime" = 100;
      "kwinrc"."Effect-Fade"."FadeOutTime" = 100;

      "kwinrc"."Plugins"."slideEnabled" = true;
      "kwinrc"."Effect-Slide"."Duration" = 150;
      "kwinrc"."Effect-Slide"."HorizontalGap" = 0;
      "kwinrc"."Effect-Slide"."VerticalGap" = 0;

      "kwinrc"."Plugins"."magiclampEnabled" = false;
      "kwinrc"."Plugins"."fallapartEnabled" = false;
      "kwinrc"."Plugins"."glideEnabled" = false;
      "kwinrc"."Plugins"."scaleEnabled" = false;
      "kwinrc"."Plugins"."slidebackEnabled" = false;

      "kwinrc"."Effect-DesktopGrid"."Animation" = "0";

      "kglobalshortcutsrc"."kwin"."Window Maximize" = "Meta+Up,Meta+PgUp,Maximiser la fenêtre";
      "kglobalshortcutsrc"."kwin"."Window Minimize" = "Meta+Down,Meta+PgDown,Réduire la fenêtre";
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
                chartType = "org.kde.ksysguard.linechart";
                showText = true;
                title = "GPU";
              };
              "Sensors" = {
                highPrioritySensorIds = "[\"gpu/all/usage\"]";
                totalSensors = "[\"gpu/all/usage\"]";
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

  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions.packages = with firefox-addons.packages.${pkgs.system}; [
        sponsorblock
        ublock-origin
        privacy-badger
      ];
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

      # Systeme
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

  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-python.vscode-pylance

        eamodio.gitlens

        # Nix
        bbenoist.nix
        jnoortheen.nix-ide

        # Icônes
        pkief.material-icon-theme

        # Utilitaires
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        ms-vscode-remote.remote-ssh

        # Thème
        github.github-vscode-theme
      ];

      userSettings = {
        # Éditeur
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrains Mono', 'monospace'";
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;
        "editor.wordWrap" = "on";
        "editor.minimap.enabled" = true;
        "editor.formatOnSave" = true;
        "editor.bracketPairColorization.enabled" = true;

        # Icônes
        "workbench.iconTheme" = "material-icon-theme";

        # Terminal
        "terminal.integrated.fontFamily" = "JetBrains Mono";
        "terminal.integrated.fontSize" = 13;

        # Fichiers
        "files.autoSave" = "onFocusChange";
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;

        # Python
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
        "[python]" = {
          "editor.tabSize" = 4;
        };

        # Git
        "git.enableSmartCommit" = true;
        "git.autofetch" = true;

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";

        # Télémétrie
        "telemetry.telemetryLevel" = "off";
      };
    };
  };
}
