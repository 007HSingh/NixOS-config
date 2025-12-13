{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Basic utilities
    wget
    curl
    git
    unzip
    zip
    tree

    # Modern CLI tools
    eza
    bat
    zoxide # Smart cd
    ripgrep # Fast grep
    fd # Fast find
    fzf # Fuzzy finder
    tlrc # Modern man pages

    # System monitoring
    mission-center
    fastfetch

    # File management
    lazygit

    # Documentation
    man-pages
    nix-index

    # Utilities
    xdg-utils
    jq

    # System management
    nvd
    nps
    nix-output-monitor

    # Youtube videos downloader
    yt-dlp
  ];
}
