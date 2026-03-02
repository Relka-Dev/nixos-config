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
                "applications:proton-pass.desktop"
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
        return-youtube-dislikes
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
  home.file.".config/waybar/config.jsonc".text = ''
    {
        "layer": "top",
        "position": "top",
        "height": 32,
        "spacing": 4,
        "modules-left": ["niri/workspaces", "niri/window"],
        "modules-center": ["clock"],
        "modules-right": ["cpu", "memory", "temperature", "pulseaudio", "network", "battery", "tray"],
        "niri/workspaces": { "format": "{index}" },
        "niri/window": { "max-length": 50 },
        "clock": { "format": "{:%H:%M}", "format-alt": "{:%Y-%m-%d %H:%M}" },
        "cpu": { "format": " {usage}%", "interval": 2 },
        "memory": { "format": " {percentage}%", "interval": 2 },
        "temperature": { "format": " {temperatureC}°C" },
        "pulseaudio": {
            "format": "{icon} {volume}%",
            "format-muted": "󰝟 muted",
            "format-icons": { "default": ["󰕿", "󰖀", "󰕾"] },
            "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        },
        "network": {
            "format-wifi": "󰤨 {signalStrength}%",
            "format-ethernet": "󰈀 {ifname}",
            "format-disconnected": "󰤭 off"
        },
        "battery": {
            "format": "{icon} {capacity}%",
            "format-icons": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰉁"],
            "format-charging": "󰂄 {capacity}%"
        },
        "tray": { "spacing": 8 }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
        font-family: "JetBrains Mono", monospace;
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
    }
    window#waybar {
        background: rgba(10, 10, 10, 0.92);
        color: #ffffff;
    }
    #workspaces button {
        padding: 0 8px;
        color: #555555;
        background: transparent;
    }
    #workspaces button.active {
        color: #ffffff;
    }
    #clock { color: #ffffff; font-weight: bold; }
    #cpu, #memory, #temperature { color: #aaaaaa; padding: 0 8px; }
    #pulseaudio { color: #aaaaaa; padding: 0 8px; }
    #pulseaudio.muted { color: #444444; }
    #network { color: #aaaaaa; padding: 0 8px; }
    #battery { color: #aaaaaa; padding: 0 8px; }
    #battery.charging { color: #ffffff; }
    #battery.critical:not(.charging) { color: #ff4444; }
    #tray { padding: 0 8px; }
  '';

  home.file.".config/fuzzel/fuzzel.ini".text = ''
    [main]
    font=JetBrains Mono:size=13
    terminal=kitty

    [colors]
    background=0f0f0fcc
    text=e0e0e0ff
    match=ffffffff
    selection=ffffff44
    selection-text=ffffffff
    border=cccccc33

    [border]
    width=1
    radius=0
  '';

  home.file.".config/swaylock/config".text = ''
    color=0f0f0f
    bs-hl-color=ffffff
    key-hl-color=ffffff
    ring-color=1a1a1a
    ring-ver-color=ffffff
    ring-wrong-color=ff4444
    inside-color=0f0f0f
    inside-ver-color=0f0f0f
    inside-wrong-color=1a1a1a
    line-color=00000000
    line-ver-color=00000000
    line-wrong-color=00000000
    text-color=e0e0e0
    text-ver-color=ffffff
    text-wrong-color=ff4444
    separator-color=00000000
    indicator-radius=80
    indicator-thickness=4
    font=JetBrains Mono
  '';

  home.file.".config/mako/config".text = ''
    background-color=#0a0a0aee
    text-color=#cccccc
    border-color=#cccccc
    border-size=1
    border-radius=0
    padding=12
    margin=8
    font=JetBrains Mono 12
    width=320
    height=100
    anchor=top-right
    default-timeout=3000
  '';

  home.file.".config/niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "ch"
                variant "fr"
            }
            numlock
        }
        touchpad {
            tap
            natural-scroll
        }
    }

    layout {
        gaps 16
        center-focused-column "never"
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width { proportion 0.5; }
        focus-ring {
            width 2
            active-color "#cccccc"
            inactive-color "#333333"
        }
        border {
            off
            width 4
            active-color "#ffc87f"
            inactive-color "#505050"
            urgent-color "#9b0000"
        }
        shadow {
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }
        struts {
            left 8
            right 8
            top 8
            bottom 8
        }
    }

    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "waybar"
    spawn-at-startup "mako"
    spawn-at-startup "kanshi"

    hotkey-overlay {}

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    animations {}

    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    window-rule {
        geometry-corner-radius 0
        clip-to-geometry true
    }

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }
        Mod+T hotkey-overlay-title="Open a Terminal: kitty" { spawn "kitty"; }
        Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }
        Super+Alt+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "swaylock"; }
        Super+Alt+S allow-when-locked=true hotkey-overlay-title=null { spawn-sh "pkill orca || exec orca"; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
        XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

        Mod+O repeat=false { toggle-overview; }
        Mod+Q repeat=false { close-window; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+J     { focus-monitor-down; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }
        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+V       { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+W { toggle-column-tabbed-display; }

        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }
        Mod+Shift+P { power-off-monitors; }
    }
  '';
}
