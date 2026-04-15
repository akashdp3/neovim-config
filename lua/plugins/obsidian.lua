local ok, obsidian = pcall(require, "obsidian")

if not ok then
	return
end

local vault = vim.fn.expand("~/Code/notes")

if vim.fn.isdirectory(vault) == 0 then
	return
end

obsidian.setup({
	workspaces = {
		{
			name = "main",
			path = vault,
		},
	},
	notes_subdir = "00-Inbox",
	new_notes_location = "notes_subdir",
	preferred_link_style = "wiki",
	daily_notes = {
		folder = "00-Inbox/01-Journal",
	},
	picker = {
		name = "telescope.nvim",
	},
	completion = {
		nvim_cmp = false,
		min_chars = 2,
	},
	templates = {
		folder = "Templates",
	},
})

vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Obsidian new note" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian quick switch" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian search" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "Obsidian today" })
