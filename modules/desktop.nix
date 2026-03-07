{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ── Niri compositor ──────────────────────────────────────────────────────────
  programs.niri.enable = true;

  # ── DMS desktop shell ────────────────────────────────────────────────────────
  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableClipboardPaste = true;
  };

  # ── Display manager : greetd + tuigreet ──────────────────────────────────────
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions \
            --remember \
            --remember-user-session
        '';
        user = "greeter";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d '/var/cache/tuigreet' - greeter greeter - -"
  ];

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # ── Sécurité ─────────────────────────────────────────────────────────────────
  security.polkit.enable = true;

  # ── Variables Wayland ────────────────────────────────────────────────────────
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    TERMINAL = "kitty";
  };

  # ── Paquets système ──────────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    kitty
    nautilus
    adwaita-icon-theme
    gnome-themes-extra
    wl-clipboard
    playerctl
    brightnessctl
    pavucontrol
  ];

  services.dbus.packages = [ pkgs.nautilus ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];
}
