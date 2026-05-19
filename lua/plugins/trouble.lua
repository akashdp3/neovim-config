local ok, trouble = pcall(require, "trouble")
if not ok then
	return
end

trouble.setup({
	focus = true,
	win = {
		type = "split",
		position = "bottom",
		size = 12,
	},
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local function o(desc)
	return vim.tbl_extend("force", opts, { desc = desc })
end

map("n", "<leader>xt", "<cmd>Trouble diagnostics toggle<CR>", o("Trouble diagnostics"))
map("n", "<leader>xT", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", o("Trouble buffer diagnostics"))
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", o("Trouble quickfix"))
map("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<CR>", o("Trouble references"))
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", o("Trouble symbols"))
