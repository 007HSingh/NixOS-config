-- ============================================================================
-- TREESITTER CONFIGURATION
-- ============================================================================

require("nvim-treesitter.configs").setup({
	-- Parsers are installed via Nix, not by Treesitter
	-- Do NOT use ensure_installed, sync_install, or auto_install

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
		},
	},
})

-- ============================================================================
-- TREESITTER CONTEXT
-- ============================================================================
require("treesitter-context").setup({
	enable = true,
	max_lines = 3,
	trim_scope = "outer",
})
