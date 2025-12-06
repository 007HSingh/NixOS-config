-- ============================================================================
-- EDITOR ENHANCEMENTS
-- ============================================================================

-- ============================================================================
-- NVIM-TREE (FILE EXPLORER)
-- ============================================================================
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
		icons = {
			show = {
				folder_arrow = true,
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	git = {
		enable = true,
		ignore = false,
	},
})

-- ============================================================================
-- TOGGLETERM (TERMINAL)
-- ============================================================================
require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
	},
})

-- ============================================================================
-- TROUBLE (DIAGNOSTICS)
-- ============================================================================
require("trouble").setup()

-- ============================================================================
-- COMMENT
-- ============================================================================
require("Comment").setup()

-- ============================================================================
-- NVIM-AUTOPAIRS
-- ============================================================================
require("nvim-autopairs").setup({
	check_ts = true,
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
		java = false,
	},
})

-- ============================================================================
-- NVIM-SURROUND
-- ============================================================================
require("nvim-surround").setup()

-- ============================================================================
-- MINI.NVIM
-- ============================================================================
require("mini.ai").setup()
require("mini.move").setup()

-- ============================================================================
-- FLASH (NAVIGATION)
-- ============================================================================
require("flash").setup()

-- Keymaps for Flash
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })

-- ============================================================================
-- ZEN MODE
-- ============================================================================
require("zen-mode").setup({
	window = {
		width = 120,
		options = {
			number = false,
			relativenumber = false,
		},
	},
})

-- ============================================================================
-- AERIAL (CODE OUTLINE)
-- ============================================================================
require("aerial").setup({
	backends = { "treesitter", "lsp" },
	layout = {
		default_direction = "prefer_right",
	},
})

-- ============================================================================
-- PERSISTENCE (SESSION MANAGEMENT)
-- ============================================================================
require("persistence").setup()
