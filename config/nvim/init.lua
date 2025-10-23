-- ============================================================================
-- NEOVIM CONFIGURATION (NixOS Hybrid Approach)
-- ============================================================================
-- Author: Harsh Singh
-- Last Updated: $(21/10/25)
-- Neovim Version: 0.10+
-- Purpose: Modern development environment with LSP, formatting, and productivity tools
-- Languages: Python, Java, Lua, Nix
-- Theme: Catppuccin Mocha
-- Management: Lazy.nvim for plugins, NixOS for LSP/formatters/linters
-- ============================================================================

-- ============================================================================
-- PERFORMANCE OPTIMIZATION
-- ============================================================================

-- Enable faster Lua module loading (Neovim 0.9+)
vim.loader.enable()

-- ============================================================================
-- PLUGIN MANAGER BOOTSTRAP
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- LEADER KEY CONFIGURATION
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- PLUGIN SPECIFICATIONS
-- ============================================================================

require("lazy").setup({

	-- ========================================
	-- CORE EDITING & NAVIGATION
	-- ========================================

	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = { "BufReadPre", "BufNewFile" } },
	{ "nvim-treesitter/nvim-treesitter-context", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },

	-- ========================================
	-- LSP (LANGUAGE SERVER PROTOCOL)
	-- ========================================

	-- Core LSP client (built into Neovim)
	{ "neovim/nvim-lspconfig" },

	-- ========================================
	-- CODE FORMATTING & LINTING
	-- ========================================

	{ "stevearc/conform.nvim" },
	{ "mfussenegger/nvim-lint" },

	-- ========================================
	-- AUTOCOMPLETION
	-- ========================================

	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "L3MON4D3/LuaSnip" },

	-- ========================================
	-- UI & VISUAL ENHANCEMENTS
	-- ========================================

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			transparent_background = false,
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = true,
				telescope = {
					enabled = true,
				},
				lsp_trouble = true,
				which_key = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
			},
		},
	},
	{ "nvim-lualine/lualine.nvim" },
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },

	-- ========================================
	-- FILE MANAGEMENT
	-- ========================================

	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- ========================================
	-- GIT INTEGRATION
	-- ========================================

	{ "lewis6991/gitsigns.nvim", event = "BufReadPre" },
	{ "tpope/vim-fugitive" },
	{ "sindrets/diffview.nvim" },

	-- ========================================
	-- TERMINAL & DEVELOPMENT WORKFLOW
	-- ========================================

	{ "akinsho/toggleterm.nvim" },

	-- ========================================
	-- ENHANCED LSP EXPERIENCE
	-- ========================================

	{ "j-hui/fidget.nvim", opts = {} },
	{ "folke/trouble.nvim" },

	-- ========================================
	-- NAVIGATION & SEARCH ENHANCEMENTS
	-- ========================================

	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- ========================================
	-- PRODUCTIVITY & EDITING HELPERS
	-- ========================================

	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
				},
			})
		end,
	},
	{ "stevearc/dressing.nvim", opts = {} },
	{ "rcarriga/nvim-notify", opts = {} },

	{ "windwp/nvim-autopairs", event = "InsertEnter" },
	{ "numToStr/Comment.nvim", opts = {} },

	-- ========================================
	-- STARTUP DASHBOARD
	-- ========================================

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
				"                                                     ",
				"           [ Ready to code with precision ]         ",
				"                   Powered by NixOS                  ",
				"                                                     ",
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recently Used Files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
				dashboard.button("n", "  NixOS Config", ":e ~/nixos-config/configuration.nix <CR>"),
				dashboard.button("l", "  Lazy", ":Lazy<CR>"),
				dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
			}

			local function footer()
				local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
				local version = vim.version()
				local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
				return datetime .. "  " .. nvim_version_info .. " • NixOS • Catppuccin Mocha"
			end

			dashboard.section.footer.val = footer()

			-- Use Catppuccin colors for dashboard
			dashboard.section.header.opts.hl = "String"
			dashboard.section.buttons.opts.hl = "Function"
			dashboard.section.footer.opts.hl = "Comment"

			vim.cmd([[
				autocmd FileType alpha setlocal nofoldenable
			]])

			alpha.setup(dashboard.opts)
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
})

-- ============================================================================
-- EDITOR OPTIONS & BEHAVIOR
-- ============================================================================

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.mouse = "a"
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8

-- ============================================================================
-- COLORSCHEME CONFIGURATION
-- ============================================================================

vim.cmd.colorscheme("catppuccin-mocha")

-- ============================================================================
-- TELESCOPE CONFIGURATION
-- ============================================================================

require("telescope").setup({
	defaults = {
		prompt_prefix = "🔍 ",
		selection_caret = "➤ ",
		sorting_strategy = "ascending",
		layout_config = { prompt_position = "top" },
	},
})

-- Telescope is already themed by Catppuccin integration, but you can customize further if needed

-- ============================================================================
-- CODE FORMATTING CONFIGURATION
-- ============================================================================

require("conform").setup({
	formatters_by_ft = {
		python = { "isort", "black" },
		java = { "google-java-format" },
		lua = { "stylua" },
		nix = { "nixfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- ============================================================================
-- LINTING CONFIGURATION
-- ============================================================================

local lint = require("lint")
lint.linters_by_ft = {
	python = { "flake8", "mypy" },
	java = { "checkstyle" },
	lua = { "luacheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

-- ============================================================================
-- TREESITTER CONFIGURATION
-- ============================================================================

require("nvim-treesitter.configs").setup({
	ensure_installed = { "python", "lua", "java", "nix" },

	highlight = { enable = true },
	indent = { enable = true },

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = "outer",
	mode = "cursor",
})

-- ============================================================================
-- AUTOCOMPLETION SETUP
-- ============================================================================

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}),

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

-- CMP is already themed by Catppuccin integration

-- ============================================================================
-- LSP (LANGUAGE SERVER PROTOCOL) SETUP
-- ============================================================================

-- Common LSP keybindings
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Capabilities for autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- PYTHON LSP (pyright installed via NixOS)
require("lspconfig").pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- JAVA LSP (jdt-language-server installed via NixOS)
require("lspconfig").jdtls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- LUA LSP (lua-language-server installed via NixOS)
require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- NIX LSP (nil installed via NixOS)
require("lspconfig").nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
})

-- ============================================================================
-- STATUS LINE CONFIGURATION
-- ============================================================================

require("lualine").setup({
	options = {
		theme = "catppuccin",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- ============================================================================
-- GIT INTEGRATION
-- ============================================================================

require("gitsigns").setup()

-- ============================================================================
-- FILE EXPLORER SETUP
-- ============================================================================

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.cmd([[
				set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
			]])
	end,
})

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
})

-- ============================================================================
-- TERMINAL INTEGRATION
-- ============================================================================

require("toggleterm").setup({
	size = 20,
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
})

-- ============================================================================
-- ENHANCED DEVELOPMENT EXPERIENCE
-- ============================================================================

require("trouble").setup()

require("nvim-autopairs").setup({
	check_ts = true,
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
		java = false,
	},
})

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================

vim.diagnostic.config({
	virtual_text = {
		prefix = "■ ",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- ============================================================================
-- KEY MAPPINGS & WHICH-KEY CONFIGURATION
-- ============================================================================

local wk = require("which-key")
wk.add({
	-- File operations
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },

	-- Git operations
	{ "<leader>g", group = "Git" },
	{ "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
	{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage" },
	{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
	{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
	{ "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame line" },
	{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
	{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
	{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
	{ "<leader>gS", "<cmd>Git<cr>", desc = "Git status" },

	-- LSP & Development
	{ "<leader>l", group = "LSP" },
	{
		"<leader>ld",
		function()
			vim.diagnostic.open_float()
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>ln",
		function()
			vim.diagnostic.goto_next()
		end,
		desc = "Next diagnostic",
	},
	{
		"<leader>lp",
		function()
			vim.diagnostic.goto_prev()
		end,
		desc = "Prev diagnostic",
	},
	{
		"<leader>la",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code action",
	},
	{
		"<leader>lf",
		function()
			require("conform").format({ lsp_fallback = true })
		end,
		desc = "Format buffer",
	},

	-- Code operations
	{ "<leader>c", group = "Code" },
	{
		"<leader>cf",
		function()
			require("conform").format({ lsp_fallback = true })
		end,
		desc = "Format file",
	},
	{
		"<leader>cl",
		function()
			lint.try_lint()
		end,
		desc = "Lint file",
	},

	-- File explorer
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },

	-- Diagnostics & Debugging (Trouble)
	{ "<leader>x", group = "Trouble" },
	{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
	{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
	{
		"<leader>xl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "LSP Definitions / references / ... (Trouble)",
	},
	{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
	{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },

	-- Terminal operations
	{ "<leader>t", group = "Terminal" },
	{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
	{ "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
	{ "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },

	-- Commenting (handled by Comment.nvim)
	{ "gc", group = "Comment" },
})

-- ============================================================================
-- CONFIGURATION SUMMARY
-- ============================================================================
--[[
		This configuration uses Catppuccin Mocha theme throughout:

		THEME CONSISTENCY:
		- Colorscheme: Catppuccin Mocha
		- Lualine: Catppuccin theme
		- All integrations use Catppuccin colors automatically
		- Matches your Waybar, Hyprland, and WezTerm aesthetics

		CATPPUCCIN INTEGRATIONS ENABLED:
		- Telescope (fuzzy finder)
		- Nvim-tree (file explorer)
		- Treesitter (syntax highlighting)
		- LSP (language servers)
		- CMP (autocompletion)
		- Gitsigns (git indicators)
		- Which-key (keybinding hints)
		- Trouble (diagnostics)
		- Indent-blankline (indent guides)
		- Notify (notifications)

		BENEFITS:
		- Unified theme across all tools
		- Better readability with Mocha's warm colors
		- Native integration support (no manual color tweaking)
		- Consistent with your system theme (NixOS + Waybar + Hyprland)

		MAINTENANCE:
		- Update plugins: :Lazy update
		- Theme updates automatically with Catppuccin plugin updates
		- No manual color adjustments needed
		--]]
