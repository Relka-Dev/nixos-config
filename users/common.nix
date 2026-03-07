{ pkgs, firefox-addons, ... }:
{
  home.stateVersion = "25.05";

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
      update = "sudo nixos-rebuild switch";
      test = "sudo nixos-rebuild test";
      rollback = "sudo nixos-rebuild switch --rollback";
      cleanup = "sudo nix-collect-garbage -d";
      generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gd = "git diff";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      ports = "netstat -tulanp";
      myip = "curl ifconfig.me";
      dj = "python manage.py";
      djrun = "python manage.py runserver";
      djmig = "python manage.py migrate";
      djmake = "python manage.py makemigrations";
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
        bbenoist.nix
        jnoortheen.nix-ide
        pkief.material-icon-theme
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        ms-vscode-remote.remote-ssh
        github.github-vscode-theme
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrains Mono', 'monospace'";
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;
        "editor.wordWrap" = "on";
        "editor.minimap.enabled" = true;
        "editor.formatOnSave" = true;
        "editor.bracketPairColorization.enabled" = true;
        "workbench.iconTheme" = "material-icon-theme";
        "terminal.integrated.fontFamily" = "JetBrains Mono";
        "terminal.integrated.fontSize" = 13;
        "files.autoSave" = "onFocusChange";
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
        "[python]" = {
          "editor.tabSize" = 4;
        };
        "git.enableSmartCommit" = true;
        "git.autofetch" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "telemetry.telemetryLevel" = "off";
      };
    };
  };

  # Config niri partagée — DMS gère keybinds/thèmes/layout via ses includes
  xdg.configFile."niri/config.kdl".text = ''
    input {
      keyboard {
        repeat-delay 200
        repeat-rate 35
        xkb {
          layout "ch"
          variant "fr"
        }
      }
      touchpad {
        tap
        natural-scroll
      }
      focus-follows-mouse max-scroll-amount="0%"
    }

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"

    layer-rule {
      match namespace="^quickshell$"
      place-within-backdrop true
    }
    layer-rule {
      match namespace="dms:blurwallpaper"
      place-within-backdrop true
    }

    // Includes gérés par DMS — générés via `dms setup` au premier login
    include "dms/binds.kdl"
    include "dms/colors.kdl"
    include "dms/layout.kdl"
    include "dms/alttab.kdl"
    include "dms/outputs.kdl"
    include "dms/cursor.kdl"
    include "dms/windowrules.kdl"
    include "dms/wpblur.kdl"
  '';

  # Évite que niri plante au premier boot avant `dms setup`
  xdg.configFile."niri/dms/.keep".text = "";
}
