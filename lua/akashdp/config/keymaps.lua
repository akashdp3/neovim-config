local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Netrw Explore project files
keymap.set("n", "<leader>ef", vim.cmd.Ex)

-- remap esc key to Control + c
keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- increment / decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- delete a word backwards
keymap.set("n", "dw", "sv_d")

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- move line up and down
keymap.set("n", "J", ":m '>+1<CR>gv=gv")
keymap.set("n", "K", ":m '<-2<CR>gv=gv")

-- split window
keymap.set("n", "ss", ":split<Return>")
keymap.set("n", "sv", ":vsplit<Return>")

-- move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostics.goto_next()
end)
