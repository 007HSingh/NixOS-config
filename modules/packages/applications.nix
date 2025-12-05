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

    # Document viewer
    kdePackages.okular
  ];
}
