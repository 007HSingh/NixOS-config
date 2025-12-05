{ config, pkgs, ... }:

{
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
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # Zoxide initialization
      eval "$(zoxide init zsh)"

      # FZF keybindings
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
    '';

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };
  };

  home.file = {
    "Downloads/Wallpapers".source = ./config/wallpapers;

    ".config/nvim/" = {
      source = ./config/nvim;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./config/waybar;
      recursive = true;

    };
    ".config/hypr" = {
      source = ./config/hyprland;
      recursive = true;
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
