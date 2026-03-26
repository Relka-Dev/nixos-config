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
    wget
    zen-browser.packages.${pkgs.system}.default
    steam
    vscode
    jetbrains.idea
    fastfetch
    krita
    qbittorrent-enhanced
    gimp2-with-plugins
    mpv
    neovim
    ripgrep
    fd
    python3
    kitty
    uv
    proton-pass
    jetbrains-toolbox
    scala
    sbt
    #networkmanagerapplet
    cbonsai
    meson
    nodejs_24
    ffmpeg_7-headless
    gh
    github-copilot-cli
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
