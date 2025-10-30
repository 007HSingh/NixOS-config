{ config, pkgs, ... }:

{
  home.username = "harshs";
  home.homeDirectory = "/home/harshs";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  catppuccin = {
    cursors.enable = true;
    fzf.enable = true;
  };

  programs.git = {
    userName = "Harsh Singh";
    userEmail = "singhharsh25032008@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      lg = "log --oneline --graph --decorate";
    };
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
    ".config/dunst/dunstrc".source = ./config/dunst/dunstrc;
    ".config/wlogout/layout".text = ''
      {
        "label" : "lock",
        "action" : "swaylock",
        "text" : "Lock",
        "keybind" : "l"
      }
      {
        "label" : "logout",
        "action" : "hyprctl dispatch exit",
        "text" : "Logout",
        "keybind" : "e"
      }
      {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
      }
      {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
      }
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
