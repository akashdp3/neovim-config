local ok, oil = pcall(require, "oil")
if not ok then
	return
end

oil.setup({
	default_file_explorer = true,
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name)
			return name == ".DS_Store"
		end,
	},
	float = {
		padding = 2,
		max_width = 0.9,
		max_height = 0.9,
		border = "rounded",
	},
	keymaps = {
		["q"] = "actions.close",
		["<Esc>"] = "actions.close",
		["<C-p>"] = "actions.preview",
		["<C-s>"] = "actions.select_split",
		["<C-v>"] = "actions.select_vsplit",
		["<C-t>"] = "actions.select_tab",
		["<C-h>"] = false,
		["<C-l>"] = false,
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })
vim.keymap.set("n", "<leader>E", "<cmd>Oil --float<CR>", { desc = "File explorer (float)" })
