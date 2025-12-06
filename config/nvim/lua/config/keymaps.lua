-- ============================================================================
-- KEYMAPS
-- ============================================================================

local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

-- ============================================================================
-- WINDOW NAVIGATION
-- ============================================================================
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- ============================================================================
-- WINDOW RESIZING
-- ============================================================================
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ============================================================================
-- BUFFER NAVIGATION
-- ============================================================================
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- ============================================================================
-- BETTER INDENTING
-- ============================================================================
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ============================================================================
-- MOVE TEXT UP AND DOWN
-- ============================================================================
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- ============================================================================
-- KEEP CURSOR CENTERED
-- ============================================================================
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- ============================================================================
-- CLEAR SEARCH HIGHLIGHTS
-- ============================================================================
keymap("n", "<Esc>", ":noh<CR>", opts)

-- ============================================================================
-- TERMINAL MODE
-- ============================================================================
keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
keymap("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================
local function toggle_relative_number()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.notify("Relative line numbers disabled", vim.log.levels.INFO)
	else
		vim.wo.relativenumber = true
		vim.notify("Relative line numbers enabled", vim.log.levels.INFO)
	end
end

keymap("n", "<leader>n", toggle_relative_number, { silent = true, desc = "Toggle Relative Numbers" })
keymap("n", "<leader><leader>", ":source %<CR>", { desc = "Source File", silent = true })
