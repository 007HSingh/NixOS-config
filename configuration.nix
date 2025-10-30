# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=0"
    "udev.log_level=3"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };
  # services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.blueman.enable = true;

  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.harshs = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Harsh Singh";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install neovim.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
  };

  # Install git.
  programs.git.enable = true;

  # Install zsh.
  programs.zsh.enable = true;

  # Install hyprland.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunar.enable = true;

  catppuccin = {
    enable = true;
    cache.enable = true;
    grub.enable = true;
    grub.flavor = "mocha";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    eza
    tree
    unzip
    zip
    mission-center
    lua
    bat
    zoxide
    brave
    wezterm
    pyright
    jdt-language-server
    lua-language-server
    lua51Packages.luarocks
    nil
    python313
    black
    isort
    mypy
    python313Packages.flake8
    stylua
    google-java-format
    checkstyle
    luajitPackages.luacheck
    jdk21_headless
    nixfmt-rfc-style
    ripgrep
    fd
    tree-sitter
    lazygit
    nodejs_24
    gcc15
    fzf
    fastfetch
    waybar
    hyprpaper
    wofi
    brightnessctl
    nwg-look
    tokyonight-gtk-theme
    numix-icon-theme
    dunst
    playerctl
    pamixer
    networkmanagerapplet
    bluez
    bluez-tools
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    hyprpicker
    papirus-icon-theme
    wlogout
    font-awesome
    material-icons
    pavucontrol
    tlrc
    spotify
    gh
    swaylock
    swayidle
    cava
    man-pages
    nix-index
    xdg-utils
    clang-tools
    vscode-fhs
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    nvidiaSettings = true;

    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
