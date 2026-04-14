local ok, which_key = pcall(require, "which-key")

if not ok then
	return
end

which_key.setup({
	preset = "modern",
	delay = 300,
	win = {
		border = "rounded",
	},
})

which_key.add({
	{ "<leader>c", group = "Code" },
	{ "<leader>f", group = "Find" },
	{ "<leader>h", group = "Git Hunks" },
	{ "<leader>s", group = "Search" },
	{ "<leader>t", group = "Toggle" },
	{ "<leader>w", group = "Window" },
	{ "<leader>x", group = "Diagnostics / Exec" },
})
