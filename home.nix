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

  home.file = {
    ".config/nvim/init.lua".source = ./config/nvim/init.lua;
    ".config/waybar/config.jsonc".source = ./config/waybar/config.jsonc;
    ".config/waybar/style.css".source = ./config/waybar/style.css;
    ".config/waybar/mocha.css".source = ./config/waybar/mocha.css;
    ".config/hypr/hyprland.conf".source = ./config/hyprland/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ./config/hyprland/hyprpaper.conf;
    ".config/wofi/config/config".source = ./config/wofi/config;
    ".config/wofi/src/mocha/style.css".source = ./config/wofi/style.css;
    ".config/dunst/dunstrc".source = ./config/dunst/dunstrc;
    ".config/wlogout/layout".source = ./config/wlogout/layout;
    ".config/hypr/hyprlock.conf".source = ./config/hyprland/hyprlock.conf;
    ".config/hypr/hypridle.conf".source = ./config/hyprland/hypridle.conf;
    ".config/hypr/scripts/check-caps.sh".source = ./config/hyprland/scripts/check-caps.sh;
    ".config/hypr/scripts/battery-status.sh".source = ./config/hyprland/scripts/battery-status.sh;
    ".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
