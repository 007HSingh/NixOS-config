-- ============================================================================
-- NEOTEST CONFIGURATION
-- ============================================================================

require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
			args = { "--log-level", "DEBUG" },
			runner = "pytest",
		}),
		require("neotest-plenary"),
	},
	status = {
		virtual_text = true,
	},
	output = {
		open_on_run = true,
	},
	quickfix = {
		open = function()
			require("trouble").open({ mode = "quickfix", focus = false })
		end,
	},
})
