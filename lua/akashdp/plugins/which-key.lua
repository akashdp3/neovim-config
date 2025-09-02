return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			preset = "modern",
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
			},
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
				align = "left",
			},
			spec = {
				{ "<leader>f", group = "󰈞 Find/Files" },
				{ "<leader>e", group = "󰙅 Explorer" },
				{ "<leader>g", group = " Git" },
				{ "<leader>l", group = " LSP" },
				{ "<leader>t", group = " Terminal/Tmux" },
				{ "<leader>tp", desc = "Switch tmux panes" },
				{ "<leader>ts", desc = "Switch tmux sessions" },
				{ "<leader>tw", desc = "Switch tmux windows" },
				{ "<leader>w", group = "󰖯 Window" },
				{ "<leader>b", group = "󰓩 Buffer" },
				{ "<leader>y", group = " Yank/Copy" },
				{ "<leader>c", group = " Code/Claude" },
				{ "<leader>cc", desc = "Open Claude Code split" },
				{ "<leader>ct", desc = "Toggle Claude Code pane" },
				{ "<leader>cn", desc = "Create nvim-claude session" },
				{ "<leader>d", group = " Debug" },
				{ "<leader>r", group = " Replace" },
				{ "<leader>s", group = "󰛔 Search" },
				{ "<leader>x", group = "󱍼 Diagnostics/Quickfix" },
				{ "<leader>a", group = "󰚩 AI" },
				{ "g", group = "Goto" },
				{ "z", group = "Fold" },
				{ "]", group = "Next" },
				{ "[", group = "Prev" },
			},
		},
	},
}
