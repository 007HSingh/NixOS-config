-- ============================================================================
-- DAP (DEBUG ADAPTER PROTOCOL) CONFIGURATION
-- ============================================================================

local dap = require("dap")
local dapui = require("dapui")

-- ============================================================================
-- DAP UI SETUP
-- ============================================================================
dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 10,
			position = "bottom",
		},
	},
})

-- ============================================================================
-- DAP VIRTUAL TEXT
-- ============================================================================
require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,
})

-- ============================================================================
-- AUTO-OPEN/CLOSE DAP UI
-- ============================================================================
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- ============================================================================
-- PYTHON DAP CONFIGURATION
-- ============================================================================
require("dap-python").setup("python3")

-- ============================================================================
-- RUST DAP CONFIGURATION
-- ============================================================================

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
	{
		name = "Launch test",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/target/debug/deps/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

-- ============================================================================
-- DAP SIGNS
-- ============================================================================
local signs = {
	DapBreakpoint = { text = "🔴", texthl = "", linehl = "", numhl = "" },
	DapBreakpointCondition = { text = "🟡", texthl = "", linehl = "", numhl = "" },
	DapBreakpointRejected = { text = "🚫", texthl = "", linehl = "", numhl = "" },
	DapStopped = { text = "➡️", texthl = "", linehl = "", numhl = "" },
}

for name, opts in pairs(signs) do
	vim.fn.sign_define(name, opts)
end
