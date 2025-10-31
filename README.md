# 🚀 Harsh's NixOS — Fun Flake Config

A minimal, opinionated NixOS flake with a spicy Catppuccin theme, Hyprland + Waybar desktop, and a power-packed Neovim config.  
Think: pixel-perfect UI, fast dev tools, and everything wired via Nix flakes.

Quick links ✨
- System config: [`configuration.nix`](configuration.nix) — see [`programs.neovim`](configuration.nix) and [`environment.systemPackages`](configuration.nix)
- Hardware scan: [`hardware-configuration.nix`](hardware-configuration.nix)
- Flake entry: [`flake.nix`](flake.nix)
- Home Manager: [`home.nix`](home.nix) — see [`home.file` mapping](home.nix)
- Dotfiles: [`config/`](config/)  
  - Neovim: [`config/nvim/init.lua`](config/nvim/init.lua)  
  - Waybar: [`config/waybar/config.jsonc`](config/waybar/config.jsonc), [`config/waybar/style.css`](config/waybar/style.css), [`config/waybar/mocha.css`](config/waybar/mocha.css)  
  - Hyprland: [`config/hyprland/hyprland.conf`](config/hyprland/hyprland.conf), [`config/hyprland/hyprlock.conf`](config/hyprland/hyprlock.conf), [`config/hyprland/hyprpaper.conf`](config/hyprland/hyprpaper.conf)  
  - Hypr scripts: [`config/hyprland/scripts/check-caps.sh`](config/hyprland/scripts/check-caps.sh), [`config/hyprland/scripts/battery-status.sh`](config/hyprland/scripts/battery-status.sh)  
  - Wofi: [`config/wofi/config`](config/wofi/config), [`config/wofi/style.css`](config/wofi/style.css)  
  - Dunst: [`config/dunst/dunstrc`](config/dunst/dunstrc)  
  - Wlogout layout: [`config/wlogout/layout`](config/wlogout/layout)  
  - Kitty: [`config/kitty/kitty.conf`](config/kitty/kitty.conf)

Highlights ✨
- Flake-based reproducible config via [`flake.nix`](flake.nix)
- Home Manager-managed dotfiles via [`home.nix`](home.nix) (`home.file` links)
- Hyprland + Waybar setup with polished Catppuccin Mocha styling
- Fully featured Neovim config at [`config/nvim/init.lua`](config/nvim/init.lua) (Lazy.nvim, LSP, DAP, Neotest)
- Handy helper scripts: check Caps Lock and battery icons

Getting started — quick commands ⚡
- Rebuild & switch system (applies system + Home Manager):
  sudo nixos-rebuild switch --flake .#nixos
- Apply only Home Manager:
  home-manager switch --flake .#harshs

Customize (short) 🔧
- Edit dotfiles in [`config/`](config/) and update the mapping in [`home.nix`](home.nix) via the [`home.file` mapping](home.nix).
- Add/remove system packages or services in [`configuration.nix`](configuration.nix) under [`environment.systemPackages`](configuration.nix) and rebuild.

Troubleshooting tips 🛠️
- Missing package? Check [`environment.systemPackages`](configuration.nix).
- Home Manager symlink issues? Inspect [`home.file` mappings](home.nix).
- Hyprland / Wayland problems: journalctl + ensure `services.displayManager` and [`programs.hyprland`](configuration.nix) are enabled in [`configuration.nix`](configuration.nix).

Contributing & notes ❤️
- This is tuned for Harsh's machine (NixOS 25.05). Feel free to fork and tweak.
- License: MIT — see [`LICENSE`](LICENSE)

Enjoy the vibes 😸