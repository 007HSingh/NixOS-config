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
    ".config/dunst".source = ./config/dunst;
    ".config/wlogout".source = ./config/wlogout;
    ".config/kitty".source = ./config/kitty;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
