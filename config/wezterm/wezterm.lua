-- ============================================================================
-- WEZTERM CONFIGURATION
-- ============================================================================
-- Author: Harsh Singh
-- Theme: Catppuccin Macchiato
-- Purpose: Beautiful, modern terminal with aesthetic vibes
-- ============================================================================

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============================================================================
-- THEME & APPEARANCE
-- ============================================================================

-- Built-in Catppuccin Mocha theme
config.color_scheme = "Catppuccin Mocha"

-- Transparency settings
config.window_background_opacity = 0.5

-- ============================================================================
-- FONT CONFIGURATION
-- ============================================================================

config.font = wezterm.font_with_fallback({
	{ family = "MesloLGS Nerd Font", weight = "Regular" },
	"Noto Color Emoji", -- Emoji support
})
config.font_size = 11.0
config.line_height = 1.2 -- Comfortable spacing
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" } -- Enable ligatures

-- ============================================================================
-- WINDOW STYLING
-- ============================================================================

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

config.window_decorations = "NONE" -- Minimal UI, resize only
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32

-- ============================================================================
-- CURSOR STYLING
-- ============================================================================

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700
config.cursor_thickness = "2px"

-- ============================================================================
-- SCROLLBACK & PERFORMANCE
-- ============================================================================

config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.animation_fps = 60
config.max_fps = 60

-- ============================================================================
-- BEHAVIOR & UX
-- ============================================================================

config.window_close_confirmation = "NeverPrompt"
config.warn_about_missing_glyphs = false
config.enable_kitty_graphics = true

-- ============================================================================
-- KEY BINDINGS (Simple & Intuitive)
-- ============================================================================

config.keys = {
	-- Tab management
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },

	-- Tab navigation
	{ key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

	-- Pane management
	{ key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "D", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Pane navigation (vim-style)
	{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

	-- Font size adjustment
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

	-- Copy/Paste
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Search
	{ key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
}

-- ============================================================================
-- STARTUP
-- ============================================================================

-- Launch Zsh as a login shell (ensures Oh My Zsh runs)
config.default_prog = { "/run/current-system/sw/bin/zsh", "-l" }

-- Optional: set default working directory
-- config.default_cwd = wezterm.home_dir .. "/projects"

-- ============================================================================
-- ADDITIONAL AESTHETICS
-- ============================================================================

config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- ============================================================================
-- CONFIGURATION SUMMARY
-- ============================================================================
--[[
FEATURES:
- Built-in Catppuccin Mocha scheme
- MesloLGS Nerd Font (for Powerline and Oh My Zsh)
- 85% transparency with blur
- Clean UI, smooth animations
- Vim-style pane navigation
- Logical keybindings for tabs, panes, copy/paste, and search
--]]

return config
