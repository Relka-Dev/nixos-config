{
  config,
  pkgs,
  zen-browser,
  ...
}:

{
  imports = [
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/maintenance.nix
    ./users/veks.nix
    ./users/karelsvbd.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    # CLI tools
    wget
    fastfetch
    uv
    scala
    sbt
    fd
    cbonsai
    nodejs_24
    ffmpeg_7-headless
    neovim
    ripgrep
    meson
    python3

    # IDEAs
    vscode
    jetbrains.idea
    jetbrains-toolbox

    # Apps
    zen-browser.packages.${pkgs.system}.default
    steam
    krita
    qbittorrent-enhanced
    gimp2-with-plugins
    mpv
    kitty
    proton-pass
    #networkmanagerapplet
    godot_4
    super-productivity
    gh
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
