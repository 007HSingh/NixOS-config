-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- ============================================================================
-- HIGHLIGHT ON YANK
-- ============================================================================
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- ============================================================================
-- RESIZE SPLITS ON WINDOW RESIZE
-- ============================================================================
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- ============================================================================
-- CLOSE CERTAIN FILETYPES WITH 'q'
-- ============================================================================
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

-- ============================================================================
-- DISABLE AUTO-COMMENTING NEW LINES
-- ============================================================================
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("disable_auto_comment", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- ============================================================================
-- CHECK IF FILE CHANGED OUTSIDE OF VIM
-- ============================================================================
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	command = "checktime",
})

-- ============================================================================
-- RESTORE CURSOR POSITION
-- ============================================================================
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
-- HIDE TABLINE IN ALPHA DASHBOARD
-- ============================================================================
vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.cmd([[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
        ]])
	end,
})
