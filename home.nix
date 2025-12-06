{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./config/nvim/neovim.nix
  ];

  home.username = "harshs";
  home.homeDirectory = "/home/harshs";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  catppuccin = {
    cursors.enable = true;
    fzf.enable = true;
    eza.enable = true;
  };

  programs.git.settings = {
    enable = true;
    user.name = "Harsh Singh";
    user.email = "singhharsh25032008@gmail.com";
    init.defaultBranch = "main";
    pull.rebase = false;
    core.editor = "nvim";

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      lg = "log --oneline --graph --decorate";
    };
  };

  programs.zsh = {
    enable = true;
    initExtraFirst = ''
      source ~/.p10k.zsh
    '';
    initExtra = ''
      eval "$(zoxide init zsh)"

      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        width = 300;
        notification_limit = 5;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        gap_size = 5;
        padding = 15;
        horizontal_padding = 15;
        frame_width = 2;
        corner_radius = 12;
        font = "JetBrainsMono Nerd Font 10";
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;

    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  home.file = {
    "Downloads/Wallpapers".source = ./config/wallpapers;

    ".config/nvim/lua" = {
      source = ./config/nvim/lua;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./config/waybar;
      recursive = true;

    };
    ".config/hypr" = {
      source = ./config/hypr/hyprland;
      recursive = true;
    };

    ".config/hypr/scripts/check-caps.sh" = {
      source = ./config/hypr/scripts/check-caps.sh;
      executable = true;
    };
    ".config/hypr/scripts/battery-status.sh" = {
      source = ./config/hypr/scripts/battery-status.sh;
      executable = true;
    };

    ".config/wofi".source = ./config/wofi;
    ".config/wlogout".source = ./config/wlogout;
    ".config/kitty".source = ./config/kitty;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
