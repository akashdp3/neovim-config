return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
			{ "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
			{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search" },
			{ "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's note" },
			{ "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's note" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
			{ "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Links" },
			{ "<leader>oi", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
		},
		opts = {
			workspaces = {
				{
					name = "garden",
					path = "~/akashdp/garden",
				},
			},
			templates = {
				folder = "Templates",
			},
			daily_notes = {
				folder = "00 Inbox",
				template = "daily.md",
			},
			new_notes_location = "current_dir",
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
		},
	},
}
