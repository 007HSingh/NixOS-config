{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Essential Wayland/Hyprland support
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk # Fallback portal
    polkit_gnome # Authentication agent
    qt5.qtwayland
    qt6.qtwayland
    wl-clip-persist # Clipboard persistence

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

    # Screenshots & screen tools
    grim
    slurp
    swappy
    hyprpicker

    # Bluetooth
    blueman

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
