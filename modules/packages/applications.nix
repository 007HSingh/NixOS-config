{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Web browsers
    brave

    # Communication
    discord
    slack

    # Productivity
    obsidian

    # Media
    spotify
    vlc

    # Document viewer
    kdePackages.okular
  ];
}
