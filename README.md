# NixOS Configuration — Harsh Singh

Minimal, opinionated NixOS configuration and user dotfiles (Hyprland, Waybar, Neovim, WezTerm, Wofi, etc).

Quick links
- System configuration: [`configuration.nix`](configuration.nix)
- Hardware scan: [`hardware-configuration.nix`](hardware-configuration.nix)
- Flake entry: [`flake.nix`](flake.nix)
- Home Manager: [`home.nix`](home.nix)
- User dotfiles: [`config/`](config/)
  - WezTerm: [`config/wezterm/wezterm.lua`](config/wezterm/wezterm.lua)
  - Neovim: [`config/nvim/init.lua`](config/nvim/init.lua)
  - Waybar: [`config/waybar/config.jsonc`](config/waybar/config.jsonc), [`config/waybar/style.css`](config/waybar/style.css), [`config/waybar/mocha.css`](config/waybar/mocha.css)
  - Hyprland: [`config/hyprland/hyprland.conf`](config/hyprland/hyprland.conf), [`config/hyprland/hyprlock.conf`](config/hyprland/hyprlock.conf), [`config/hyprland/hyprpaper.conf`](config/hyprland/hyprpaper.conf), scripts: [`config/hyprland/scripts/check-caps.sh`](config/hyprland/scripts/check-caps.sh), [`config/hyprland/scripts/battery-status.sh`](config/hyprland/scripts/battery-status.sh)
  - Wofi: [`config/wofi/config`](config/wofi/config), style: [`config/wofi/style.css`](config/wofi/style.css)
  - Dunst: [`config/dunst/dunstrc`](config/dunst/dunstrc)
  - Wlogout layout: [`config/wlogout/layout`](config/wlogout/layout)
- License: [`LICENSE`](LICENSE)

Overview
- This repository is a Nix flake-based configuration for a personal NixOS system.
- System-level configuration and packages live in [`configuration.nix`](configuration.nix) (see `environment.systemPackages`).
- User/home configuration is managed via Home Manager in [`home.nix`](home.nix) (see `home.username`).
- The flake entrypoint is [`flake.nix`](flake.nix) and exposes a NixOS system build.

Common tasks
- Rebuild and switch system (applies system + included home-manager module):
  sudo nixos-rebuild switch --flake .#nixos

- Apply only Home Manager for the local user (if needed):
  home-manager switch --flake .#harshs

Notes & conventions
- Dotfiles in `config/` are symlinked into the user home by Home Manager as listed in [`home.nix`](home.nix).
- Hyprland is configured in [`config/hyprland/hyprland.conf`](config/hyprland/hyprland.conf); lock and idle are handled by [`config/hyprland/hyprlock.conf`](config/hyprland/hyprlock.conf) and [`config/hyprland/hypridle.conf`](config/hyprland/hypridle.conf).
- Waybar (status bar) config and styling live in [`config/waybar/`](config/waybar/).
- Neovim configuration is centralized in [`config/nvim/init.lua`](config/nvim/init.lua) using lazy.nvim plugin management.

Troubleshooting tips
- If a package or theme is missing, check `environment.systemPackages` in [`configuration.nix`](configuration.nix).
- To debug Home Manager file links, inspect the paths declared in [`home.nix`](home.nix).
- For Hyprland/Wayland issues, check logs (journalctl) and ensure `services.displayManager` and `programs.hyprland` are enabled in [`configuration.nix`](configuration.nix).

Contributing / Personalizing
- To add or change a dotfile, edit the file in `config/` and update the mapping in [`home.nix`](home.nix).
- To add system packages or services, edit [`configuration.nix`](configuration.nix) and rebuild.

License
- MIT — see [`LICENSE`](LICENSE).