{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.niri.enable = true;

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

  # ── DankGreeter (remplace greetd + tuigreet) ─────────────────────────────────
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/veks"; # user principal pour sync du thème
  };

  security.polkit.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    TERMINAL = "kitty";
  };

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
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];
}
