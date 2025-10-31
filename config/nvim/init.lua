-- ============================================================================
-- NEOVIM CONFIGURATION
-- ============================================================================
-- Author: Harsh Singh
-- Last Updated: Oct, 2025
-- Neovim Version: 0.10+
-- Purpose: Modern development environment with LSP, formatting, and productivity tools
-- Languages: Python, Java, Lua, Nix, C
-- Theme: Catppuccin Mocha
-- Management: Lazy.nvim for plugins, NixOS for LSP/formatters/linters
-- ============================================================================

-- ============================================================================
-- PERFORMANCE OPTIMIZATION
-- ============================================================================

vim.loader.enable()

-- ============================================================================
-- LEADER KEY CONFIGURATION (Must be set before plugins)
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
-- EDITOR OPTIONS & BEHAVIOR
-- ============================================================================

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI & Behavior
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus" -- System clipboard
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmode = false -- Lualine shows mode

-- File Handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Command Line
vim.opt.cmdheight = 1
vim.opt.showcmd = true

-- ============================================================================
-- PLUGIN SPECIFICATIONS
-- ============================================================================

require("lazy").setup({

	-- ========================================
	-- CORE EDITING & NAVIGATION
	-- ========================================

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	-- ========================================
	-- LSP (LANGUAGE SERVER PROTOCOL)
	-- ========================================

	{ "neovim/nvim-lspconfig" },
	{ "folke/lazydev.nvim", ft = "lua", opts = {} }, -- Better Lua LSP support

	-- ========================================
	-- CODE FORMATTING & LINTING
	-- ========================================

	{ "stevearc/conform.nvim" },
	{ "mfussenegger/nvim-lint" },

	-- ========================================
	-- AUTOCOMPLETION
	-- ========================================

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

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
				mini = { enabled = true },
				telescope = { enabled = true },
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

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{ "folke/which-key.nvim", event = "VeryLazy" },

	-- ========================================
	-- FILE MANAGEMENT
	-- ========================================

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	},

	-- Better buffer management
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- ========================================
	-- GIT INTEGRATION
	-- ========================================

	{ "lewis6991/gitsigns.nvim", event = "BufReadPre" },
	{ "tpope/vim-fugitive", cmd = { "Git", "G" } },
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },

	-- ========================================
	-- TERMINAL & DEVELOPMENT WORKFLOW
	-- ========================================

	{ "akinsho/toggleterm.nvim", version = "*" },

	-- ========================================
	-- ENHANCED LSP EXPERIENCE
	-- ========================================

	{ "j-hui/fidget.nvim", opts = {} },
	{ "folke/trouble.nvim", cmd = "Trouble" },

	-- ========================================
	-- NAVIGATION & SEARCH ENHANCEMENTS
	-- ========================================

	{ "lukas-reineke/indent-blankline.nvim", main = "ibl" },

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
		},
	},

	-- Better f/F/t/T motions
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				width = 120,
				options = {
					number = false,
					relativenumber = false,
				},
			},
		},
	},

	-- ========================================
	-- PRODUCTIVITY & EDITING HELPERS
	-- ========================================

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "rcarriga/nvim-notify", lazy = false },
	{ "windwp/nvim-autopairs", event = "InsertEnter" },
	{ "numToStr/Comment.nvim", event = "VeryLazy" },
	{ "kylechui/nvim-surround", event = "VeryLazy", config = true },

	-- Better code structure view
	{
		"stevearc/aerial.nvim",
		cmd = { "AerialToggle", "AerialOpen" },
		opts = {
			backends = { "treesitter", "lsp" },
			layout = { default_direction = "prefer_right" },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
	},

	-- ========================================
	-- STARTUP DASHBOARD
	-- ========================================

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- ========================================
	-- MINI.NVIM - Collection of small utilities
	-- ========================================

	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.ai").setup() -- Better text objects
			require("mini.move").setup() -- Move lines/selections
		end,
	},
}, {
	ui = {
		border = "rounded",
	},
})

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
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

-- Load extensions
pcall(require("telescope").load_extension, "fzf")

-- ============================================================================
-- CODE FORMATTING CONFIGURATION
-- ============================================================================

require("conform").setup({
	formatters_by_ft = {
		python = { "isort", "black" },
		java = { "google-java-format" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		markdown = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
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
	c = { "clangtidy" },
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
	ensure_installed = { "python", "lua", "java", "nix", "c", "cpp", "markdown", "bash" },
	sync_install = false,
	auto_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

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

require("treesitter-context").setup({
	enable = true,
	max_lines = 3,
	trim_scope = "outer",
})

-- ============================================================================
-- AUTOCOMPLETION SETUP
-- ============================================================================

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer", keyword_length = 3 },
	}),

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for `:`
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- ============================================================================
-- LSP (LANGUAGE SERVER PROTOCOL) SETUP
-- ============================================================================

-- Common LSP keybindings
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

	-- Enable inlay hints if supported
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

-- Capabilities for autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP Servers
local lspconfig = require("lspconfig")

-- Python
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

-- Java
lspconfig.jdtls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Lua
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
			hint = { enable = true },
		},
	},
})

-- Nix
lspconfig.nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = { command = { "nixfmt" } },
		},
	},
})

-- C/C++
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
	},
})

-- ============================================================================
-- STATUS LINE CONFIGURATION
-- ============================================================================

require("lualine").setup({
	options = {
		theme = "catppuccin",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- ============================================================================
-- BUFFER LINE CONFIGURATION
-- ============================================================================

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		separator_style = "slant",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})

-- ============================================================================
-- GIT INTEGRATION
-- ============================================================================

require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
		map("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })

		-- Actions
		map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
		map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Stage hunk" })
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Reset hunk" })
		map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
		map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
		map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
		map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "Blame line" })
		map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
	end,
})

-- ============================================================================
-- FILE EXPLORER SETUP
-- ============================================================================

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = { width = 30 },
	renderer = {
		group_empty = true,
		icons = {
			show = { folder_arrow = true },
		},
	},
	filters = { dotfiles = false },
	git = { enable = true, ignore = false },
})

-- ============================================================================
-- TERMINAL INTEGRATION
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

require("Comment").setup()

require("ibl").setup({
	indent = { char = "│" },
	scope = { enabled = true },
})

-- ============================================================================
-- NOTIFICATION CONFIGURATION
-- ============================================================================

require("notify").setup({
	background_colour = "#1e1e2e",
	fps = 60,
	render = "compact",
	stages = "fade_in_slide_out",
	timeout = 3000,
	top_down = false,
})

vim.notify = require("notify")

-- ============================================================================
-- NOICE CONFIGURATION
-- ============================================================================

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
		inc_rename = false,
		lsp_doc_border = true,
	},
})

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================

vim.diagnostic.config({
	virtual_text = { prefix = "●" },
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

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ============================================================================
-- ALPHA DASHBOARD CONFIGURATION
-- ============================================================================

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
}

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "  Recently Used Files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
	dashboard.button("s", "  Restore Session", ":lua require('persistence').load() <CR>"),
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

dashboard.section.header.opts.hl = "String"
dashboard.section.buttons.opts.hl = "Function"
dashboard.section.footer.opts.hl = "Comment"

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.cmd([[
			set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
		]])
	end,
})

-- ============================================================================
-- KEY MAPPINGS & WHICH-KEY CONFIGURATION
-- ============================================================================

-- Basic keymaps
local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer", silent = true })

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor centered
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Clear search highlights
keymap("n", "<Esc>", ":noh<CR>", opts)

-- Save and quit shortcuts
keymap("n", "<leader>w", ":w<CR>", { desc = "Save", silent = true })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit", silent = true })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all", silent = true })

-- Which-key setup
local wk = require("which-key")

wk.setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	window = {
		border = "rounded",
		position = "bottom",
	},
})

-- Which-key mappings
wk.add({
	-- File operations
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
	{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find Word" },
	{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
	{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },

	-- Git operations
	{ "<leader>g", group = "Git" },
	{ "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
	{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
	{ "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
	{ "<leader>gP", "<cmd>Git pull<cr>", desc = "Pull" },
	{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
	{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
	{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
	{ "<leader>gC", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },

	-- Git hunks (from gitsigns)
	{ "<leader>h", group = "Git Hunks" },

	-- LSP operations
	{ "<leader>l", group = "LSP" },
	{
		"<leader>ld",
		function()
			vim.diagnostic.open_float()
		end,
		desc = "Line Diagnostics",
	},
	{
		"<leader>lD",
		"<cmd>Telescope diagnostics<cr>",
		desc = "Workspace Diagnostics",
	},
	{
		"<leader>ln",
		function()
			vim.diagnostic.goto_next()
		end,
		desc = "Next Diagnostic",
	},
	{
		"<leader>lp",
		function()
			vim.diagnostic.goto_prev()
		end,
		desc = "Prev Diagnostic",
	},
	{
		"<leader>la",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code Action",
	},
	{
		"<leader>lf",
		function()
			require("conform").format({ lsp_fallback = true })
		end,
		desc = "Format",
	},
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info" },
	{ "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart LSP" },
	{
		"<leader>lh",
		function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end,
		desc = "Toggle Inlay Hints",
	},

	-- Code operations
	{ "<leader>c", group = "Code" },
	{
		"<leader>cf",
		function()
			require("conform").format({ lsp_fallback = true })
		end,
		desc = "Format",
	},
	{
		"<leader>cl",
		function()
			lint.try_lint()
		end,
		desc = "Lint",
	},
	{ "<leader>co", "<cmd>AerialToggle<cr>", desc = "Code Outline" },

	-- Buffer operations
	{ "<leader>b", group = "Buffer" },
	{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
	{ "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
	{ "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
	{ "<leader>bD", "<cmd>%bd|e#|bd#<cr>", desc = "Delete All Buffers" },
	{ "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },

	-- File explorer
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer" },
	{ "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Focus Explorer" },

	-- Diagnostics (Trouble)
	{ "<leader>x", group = "Trouble" },
	{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
	{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols" },
	{ "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP References" },
	{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
	{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },

	-- Terminal
	{ "<leader>t", group = "Terminal" },
	{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
	{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal" },
	{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical" },
	{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle" },

	-- Session management
	{ "<leader>s", group = "Session" },
	{
		"<leader>ss",
		function()
			require("persistence").load()
		end,
		desc = "Restore Session",
	},
	{
		"<leader>sl",
		function()
			require("persistence").load({ last = true })
		end,
		desc = "Restore Last Session",
	},
	{
		"<leader>sd",
		function()
			require("persistence").stop()
		end,
		desc = "Stop Session",
	},

	-- Zen mode
	{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },

	-- Markdown preview
	{ "<leader>m", group = "Markdown" },
	{ "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Preview" },
	{ "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Preview" },
	{ "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Preview" },

	-- Lazy plugin manager
	{ "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy" },
})

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Close certain windows with 'q'
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"help",
		"lspinfo",
		"man",
		"qf",
		"startuptime",
		"checkhealth",
		"fugitive",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("disable_auto_comment", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Check if file changed outside of vim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	command = "checktime",
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- ============================================================================
-- CUSTOM FUNCTIONS
-- ============================================================================

-- Toggle relative line numbers
local function toggle_relative_number()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.notify("Relative line numbers disabled", vim.log.levels.INFO)
	else
		vim.wo.relativenumber = true
		vim.notify("Relative line numbers enabled", vim.log.levels.INFO)
	end
end

vim.keymap.set("n", "<leader>n", toggle_relative_number, { desc = "Toggle Relative Numbers", silent = true })

-- Quick source current file
vim.keymap.set("n", "<leader><leader>", ":source %<CR>", { desc = "Source File", silent = true })

-- ============================================================================
-- TERMINAL MODE KEYMAPS
-- ============================================================================

-- Better terminal navigation
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

-- Exit terminal mode easily
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)

-- ============================================================================
-- PERFORMANCE TIPS
-- ============================================================================

-- Disable some built-in plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- ============================================================================
-- CONFIGURATION SUMMARY & IMPROVEMENTS
-- ============================================================================
--[[
MAJOR IMPROVEMENTS OVER PREVIOUS CONFIG:

1. BETTER ORGANIZATION:
   - Clearer section headers
   - Logical grouping of related configurations
   - More comments explaining each section

2. ENHANCED FEATURES:
   ✨ BufferLine - Better buffer/tab management
   ✨ Aerial - Code outline/structure viewer
   ✨ Persistence - Session management
   ✨ Mini.nvim - Additional text objects and line movement
   ✨ Zen Mode - Distraction-free coding
   ✨ Markdown Preview - Live markdown rendering
   ✨ Nvim-surround - Easy surrounding text manipulation
   ✨ Better Telescope integration with FZF

3. IMPROVED COMPLETION:
   - More completion sources (buffer, path, cmdline)
   - Better Tab/S-Tab navigation
   - Snippet support via LuaSnip
   - Friendly-snippets integration

4. ENHANCED LSP:
   - Inlay hints support
   - Better keybindings
   - More LSP actions exposed
   - Clangd with more features

5. BETTER KEYMAPS:
   - More intuitive window navigation
   - Buffer management shortcuts
   - Better text movement in visual mode
   - Terminal mode improvements
   - Session management keys

6. QUALITY OF LIFE:
   - Auto-highlight yanked text
   - Auto-resize splits
   - Remember last cursor position
   - Better diagnostic icons
   - Centered cursor on movements
   - Quick file sourcing

7. PERFORMANCE:
   - Disabled unused built-in plugins
   - Lazy loading for many plugins
   - Better event handling

8. UI IMPROVEMENTS:
   - Better diagnostic signs
   - Rounded borders everywhere
   - Improved notifications
   - Better status line with globalstatus
   - BufferLine integration with file explorer

9. GIT ENHANCEMENTS:
   - More Gitsigns keybindings
   - Better Git integration
   - Telescope Git pickers

10. AUTOCOMMANDS:
    - Highlight on yank
    - Auto-resize splits
    - Close certain buffers with 'q'
    - Disable auto-commenting
    - Check for file changes

USAGE TIPS:
- Press <Space> to see all leader keybindings (Which-Key)
- Use <C-\> to toggle terminal
- Use <S-h> and <S-l> to navigate buffers
- Use 's' for Flash jump navigation
- Press <leader>z for zen mode
- Press <leader>ss to restore last session
- Use <leader>co for code outline
- Press <leader>e to toggle file explorer

NEXT STEPS TO CONSIDER:
- Add DAP (Debug Adapter Protocol) for debugging
- Add testing integration (neotest)
- Add project-specific configurations
- Add more language-specific plugins
- Customize colors further if needed
--]]
