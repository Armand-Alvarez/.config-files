vim.g.mapleader = " "

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Quit out of tab
map("n", "<leader>qt", "<CMD>tabclose<CR>")

-- Quit
map("n", "<leader>qq", "<CMD>q<CR>")

-- Exit insert mode
map("i", "jk", "<ESC>")

-- Exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>")

-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")

-- Run current Python file in a terminal split below
map("n", "<leader>rf", function()
	-- Save the file first (optional)
	vim.cmd("write")

	-- Open a split terminal below and run the file
	vim.cmd("belowright split | terminal python3 %")
end)

-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- NeoTree
map("n", "<leader>tt", "<CMD>Neotree toggle<CR>")

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") --{ desc = "Fuzzy find files in cwd" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") --{ desc = "Fuzzy find recent files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") --{ desc = "Find string in cwd" })
map("n", "<leader>fs", "<cmd>Telescope git_status<cr>") --{ desc = "Find string under cursor in cwd" })
map("n", "<leader>fc", "<cmd>Telescope git commits<cr>") --{ desc = "Find todos" })

-- Neogit
map("n", "<leader>gg", "<cmd>Neogit kind=floating<CR>")
