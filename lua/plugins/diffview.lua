local ok, diffview = pcall(require, "diffview")
if not ok then
	return
end

diffview.setup({
	enhanced_diff_hl = true,
	view = {
		default = { layout = "diff2_horizontal" },
		merge_tool = { layout = "diff3_horizontal" },
		file_history = { layout = "diff2_horizontal" },
	},
	file_panel = {
		listing_style = "tree",
		win_config = {
			position = "left",
			width = 35,
		},
	},
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local function o(desc)
	return vim.tbl_extend("force", opts, { desc = desc })
end

map("n", "<leader>gv", "<cmd>DiffviewOpen<CR>", o("Diffview open"))
map("n", "<leader>gV", "<cmd>DiffviewFileHistory %<CR>", o("Current file history"))
map("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", o("Git history"))
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", o("Diffview close"))
