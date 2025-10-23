{ config, pkgs, ... }:

{
  home.username = "harshs";
  home.homeDirectory = "/home/harshs";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  catppuccin = {
    cursors.enable = true;
  };

  home.file = {
    ".config/wezterm/wezterm.lua".source = ./config/wezterm/wezterm.lua;
    ".config/nvim/init.lua".source = ./config/nvim/init.lua;
    ".config/waybar/config.jsonc".source = ./config/waybar/config.jsonc;
    ".config/waybar/style.css".source = ./config/waybar/style.css;
    ".config/waybar/mocha.css".source = ./config/waybar/mocha.css;
    ".config/hypr/hyprland.conf".source = ./config/hyprland/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ./config/hyprland/hyprpaper.conf;
    ".config/wofi/config/config".source = ./config/wofi/config;
    ".config/wofi/src/mocha/style.css".source = ./config/wofi/style.css;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
