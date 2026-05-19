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
	{ "<leader>d", group = "Debug" },
	{ "<leader>f", group = "Find" },
	{ "<leader>g", group = "Git" },
	{ "<leader>h", group = "Git Hunks" },
	{ "<leader>o", group = "Notes / Lines" },
	{ "<leader>s", group = "Session" },
	{ "<leader>t", group = "Toggle" },
	{ "<leader>u", group = "UI / Undo" },
	{ "<leader>e", group = "Explorer" },
	{ "<leader>w", group = "Window" },
	{ "<leader>x", group = "Diagnostics / Lint / Exec" },
})
