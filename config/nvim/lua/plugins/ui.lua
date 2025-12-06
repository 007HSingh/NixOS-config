-- ============================================================================
-- UI CONFIGURATION
-- ============================================================================

-- ============================================================================
-- COLORSCHEME
-- ============================================================================
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
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
		dap = { enabled = true, enable_ui = true },
		neotest = true,
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
})

vim.cmd.colorscheme("catppuccin-mocha")

-- ============================================================================
-- LUALINE (STATUS LINE)
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
		lualine_x = {
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- ============================================================================
-- BUFFERLINE
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
-- ALPHA DASHBOARD
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
	"              Powered by NixOS • Debugging • Testing ",
}

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "  Recently Used Files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/lua/ <CR>"),
	dashboard.button("s", "  Restore Session", ":lua require('persistence').load() <CR>"),
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

-- ============================================================================
-- INDENT BLANKLINE
-- ============================================================================
require("ibl").setup({
	indent = { char = "│" },
	scope = { enabled = true },
})

-- ============================================================================
-- NVIM-NOTIFY
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
-- NOICE
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
-- DRESSING
-- ============================================================================
require("dressing").setup()

-- ============================================================================
-- WHICH-KEY
-- ============================================================================
local wk = require("which-key")

wk.setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
	window = {
		border = "rounded",
		position = "bottom",
	},
})

-- Which-key mappings
wk.add({
	-- File operations
	{ "<leader>f", group = "📁 Find", icon = "" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files", icon = "" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep", icon = "" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", icon = "" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", icon = "" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", icon = "" },
	{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find Word", icon = "" },
	{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", icon = "" },
	{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks", icon = "" },

	-- Git operations
	{ "<leader>g", group = "🔀 Git", icon = "" },
	{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit", icon = "" },
	{ "<leader>gG", "<cmd>Git<cr>", desc = "Git Status", icon = "" },
	{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit", icon = "" },
	{ "<leader>gp", "<cmd>Git push<cr>", desc = "Push", icon = "" },
	{ "<leader>gP", "<cmd>Git pull<cr>", desc = "Pull", icon = "" },
	{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches", icon = "" },
	{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View", icon = "" },
	{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History", icon = "" },
	{ "<leader>gC", "<cmd>DiffviewClose<cr>", desc = "Close Diffview", icon = "" },

	-- Git hunks
	{ "<leader>h", group = "📄 Git Hunks", icon = "" },

	-- LSP operations
	{ "<leader>l", group = "💡 LSP", icon = "" },
	{
		"<leader>ld",
		function()
			vim.diagnostic.open_float()
		end,
		desc = "Line Diagnostics",
		icon = "",
	},
	{ "<leader>lD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", icon = "" },
	{
		"<leader>ln",
		function()
			vim.diagnostic.goto_next()
		end,
		desc = "Next Diagnostic",
		icon = "",
	},
	{
		"<leader>lp",
		function()
			vim.diagnostic.goto_prev()
		end,
		desc = "Prev Diagnostic",
		icon = "",
	},
	{
		"<leader>la",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code Action",
		icon = "",
	},
	{
		"<leader>lf",
		function()
			require("conform").format({ lsp_fallback = true })
		end,
		desc = "Format",
		icon = "",
	},
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info", icon = "" },
	{ "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart LSP", icon = "" },
	{
		"<leader>lh",
		function()
			if vim.lsp.inlay_hint then
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end
		end,
		desc = "Toggle Inlay Hints",
		icon = "",
	},

	-- Debugging (DAP)
	{ "<leader>d", group = "🐛 Debug", icon = "" },
	{
		"<leader>db",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Toggle Breakpoint",
		icon = "🔴",
	},
	{
		"<leader>dB",
		function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end,
		desc = "Conditional Breakpoint",
		icon = "🟡",
	},
	{
		"<leader>dc",
		function()
			require("dap").continue()
		end,
		desc = "Continue",
		icon = "▶️",
	},
	{
		"<leader>di",
		function()
			require("dap").step_into()
		end,
		desc = "Step Into",
		icon = "⬇️",
	},
	{
		"<leader>do",
		function()
			require("dap").step_over()
		end,
		desc = "Step Over",
		icon = "➡️",
	},
	{
		"<leader>dO",
		function()
			require("dap").step_out()
		end,
		desc = "Step Out",
		icon = "⬆️",
	},
	{
		"<leader>dr",
		function()
			require("dap").repl.toggle()
		end,
		desc = "Toggle REPL",
		icon = "",
	},
	{
		"<leader>dl",
		function()
			require("dap").run_last()
		end,
		desc = "Run Last",
		icon = "",
	},
	{
		"<leader>dt",
		function()
			require("dap").terminate()
		end,
		desc = "Terminate",
		icon = "⏹️",
	},
	{
		"<leader>du",
		function()
			require("dapui").toggle()
		end,
		desc = "Toggle UI",
		icon = "",
	},
	{
		"<leader>de",
		function()
			require("dapui").eval()
		end,
		desc = "Eval",
		icon = "",
		mode = { "n", "v" },
	},

	-- Testing (Neotest)
	{ "<leader>T", group = "🧪 Test", icon = "" },
	{
		"<leader>Tr",
		function()
			require("neotest").run.run()
		end,
		desc = "Run Nearest Test",
		icon = "",
	},
	{
		"<leader>Tf",
		function()
			require("neotest").run.run(vim.fn.expand("%"))
		end,
		desc = "Run File Tests",
		icon = "",
	},
	{
		"<leader>Td",
		function()
			require("neotest").run.run({ strategy = "dap" })
		end,
		desc = "Debug Nearest Test",
		icon = "",
	},
	{
		"<leader>Ts",
		function()
			require("neotest").run.stop()
		end,
		desc = "Stop Test",
		icon = "",
	},
	{
		"<leader>Ta",
		function()
			require("neotest").run.attach()
		end,
		desc = "Attach Test",
		icon = "",
	},
	{
		"<leader>To",
		function()
			require("neotest").output.open({ enter = true })
		end,
		desc = "Show Output",
		icon = "",
	},
	{
		"<leader>TS",
		function()
			require("neotest").summary.toggle()
		end,
		desc = "Toggle Summary",
		icon = "",
	},
	{
		"<leader>Tw",
		function()
			require("neotest").watch.toggle()
		end,
		desc = "Toggle Watch",
		icon = "",
	},

	-- Code operations
	{ "<leader>c", group = "💻 Code", icon = "" },
	{
		"<leader>cf",
		function()
			require("conform").format({ lsp_fallback = true })
		end,
		desc = "Format",
		icon = "",
	},
	{
		"<leader>cl",
		function()
			require("lint").try_lint()
		end,
		desc = "Lint",
		icon = "",
	},
	{ "<leader>co", "<cmd>AerialToggle<cr>", desc = "Code Outline", icon = "" },

	-- Buffer operations
	{ "<leader>b", group = "📄 Buffer", icon = "" },
	{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer", icon = "" },
	{ "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer", icon = "" },
	{ "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer", icon = "" },
	{ "<leader>bD", "<cmd>%bd|e#|bd#<cr>", desc = "Delete All Buffers", icon = "" },
	{ "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer", icon = "" },

	-- File explorer
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "📁 File Explorer", icon = "" },
	{ "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Focus Explorer", icon = "" },

	-- Diagnostics (Trouble)
	{ "<leader>x", group = "🚨 Trouble", icon = "" },
	{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics", icon = "" },
	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics", icon = "" },
	{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols", icon = "" },
	{ "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP References", icon = "" },
	{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List", icon = "" },
	{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List", icon = "" },

	-- Terminal
	{ "<leader>t", group = "💻 Terminal", icon = "" },
	{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", icon = "" },
	{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal", icon = "" },
	{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical", icon = "" },
	{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle", icon = "" },

	-- Session management
	{ "<leader>s", group = "💾 Session", icon = "" },
	{
		"<leader>ss",
		function()
			require("persistence").load()
		end,
		desc = "Restore Session",
		icon = "",
	},
	{
		"<leader>sl",
		function()
			require("persistence").load({ last = true })
		end,
		desc = "Restore Last Session",
		icon = "",
	},
	{
		"<leader>sd",
		function()
			require("persistence").stop()
		end,
		desc = "Stop Session",
		icon = "",
	},

	-- Markdown preview
	{ "<leader>m", group = "📝 Markdown", icon = "" },
	{ "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Preview", icon = "" },
	{ "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Preview", icon = "" },
	{ "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Preview", icon = "" },

	-- Misc
	{ "<leader>w", "<cmd>w<CR>", desc = "💾 Save", icon = "" },
	{ "<leader>q", "<cmd>q<CR>", desc = "🚪 Quit", icon = "" },
	{ "<leader>Q", "<cmd>qa!<CR>", desc = "⚠️  Quit All", icon = "" },
	{ "<leader>z", "<cmd>ZenMode<cr>", desc = "🧘 Zen Mode", icon = "" },
})
