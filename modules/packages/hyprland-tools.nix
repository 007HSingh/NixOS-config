{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hyprland core
    waybar
    hyprpaper
    hyprlock
    hypridle
    wofi
    wlogout

    # System utilities
    brightnessctl
    dunst
    playerctl
    pamixer
    networkmanagerapplet
    pavucontrol

    # Bluetooth
    bluez
    bluez-tools

    # Screenshots & screen tools
    grim
    slurp
    swappy
    hyprpicker

    # Clipboard
    wl-clipboard
    cliphist

    # Themes & appearance
    nwg-look
    tokyonight-gtk-theme
    numix-icon-theme
    papirus-icon-theme
    font-awesome
    material-icons

    # Terminal
    kitty

    # Audio visualizer
    cava
  ];
}
