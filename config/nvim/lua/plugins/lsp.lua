-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ============================================================================
-- ON_ATTACH FUNCTION
-- ============================================================================
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, silent = true }

	-- LSP keybindings
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

	-- Enable inlay hints if supported
	if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

-- ============================================================================
-- PYTHON LSP
-- ============================================================================
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

-- ============================================================================
-- JAVA LSP
-- ============================================================================
lspconfig.jdtls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- ============================================================================
-- LUA LSP
-- ============================================================================
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

-- ============================================================================
-- NIX LSP
-- ============================================================================
lspconfig.nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = { command = { "nixfmt" } },
		},
	},
})

-- ============================================================================
-- C/C++ LSP
-- ============================================================================
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
-- RUST LSP
-- ============================================================================
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			-- Enable all features
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			-- Enable procedural macro support
			procMacro = {
				enable = true,
			},
			-- Check on save settings
			checkOnSave = {
				command = "clippy",
				extraArgs = { "--all", "--", "-W", "clippy::all" },
			},
			-- Inlay hints
			inlayHints = {
				bindingModeHints = {
					enable = false,
				},
				chainingHints = {
					enable = true,
				},
				closingBraceHints = {
					enable = true,
					minLines = 25,
				},
				closureReturnTypeHints = {
					enable = "never",
				},
				lifetimeElisionHints = {
					enable = "never",
					useParameterNames = false,
				},
				maxLength = 25,
				parameterHints = {
					enable = true,
				},
				reborrowHints = {
					enable = "never",
				},
				renderColons = true,
				typeHints = {
					enable = true,
					hideClosureInitialization = false,
					hideNamedConstructor = false,
				},
			},
			-- Diagnostics
			diagnostics = {
				enable = true,
				experimental = {
					enable = true,
				},
			},
		},
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

-- Diagnostic signs
local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ============================================================================
-- FORMATTING & LINTING
-- ============================================================================

-- Conform (formatting)
require("conform").setup({
	formatters_by_ft = {
		python = { "ruff" },
		java = { "google-java-format" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		markdown = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- Nvim-lint (linting)
local lint = require("lint")
lint.linters_by_ft = {
	python = { "ruff", "mypy" },
	java = { "checkstyle" },
	lua = { "luacheck" },
	rust = { "clippy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

-- ============================================================================
-- FIDGET (LSP PROGRESS)
-- ============================================================================
require("fidget").setup()

-- ============================================================================
-- LAZYDEV (LUA LSP FOR NEOVIM)
-- ============================================================================
require("lazydev").setup()
