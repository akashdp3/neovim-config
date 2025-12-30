-- Developer Experience plugins for better diagnostics, documentation, and navigation
return {
	-- Trouble.nvim - Better diagnostics list
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cS",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP references/definitions (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
		opts = {
			focus = true,
			auto_preview = true,
			auto_refresh = true,
			preview = {
				type = "split",
				relative = "win",
				position = "right",
				size = 0.4,
			},
			modes = {
				symbols = {
					win = { position = "right" },
				},
			},
		},
	},

	-- Glance.nvim - Peek definitions/references without leaving context
	{
		"dnlhc/glance.nvim",
		cmd = "Glance",
		keys = {
			{ "gD", "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
			{ "gR", "<cmd>Glance references<cr>", desc = "Glance references" },
			{ "gY", "<cmd>Glance type_definitions<cr>", desc = "Glance type definitions" },
			{ "gM", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
		},
		opts = {
			height = 20,
			border = {
				enable = true,
			},
			preview_win_opts = {
				cursorline = true,
				number = true,
				wrap = true,
			},
			list = {
				position = "right",
				width = 0.33,
			},
			theme = {
				enable = true,
			},
			hooks = {
				before_open = function(results, open, jump, method)
					-- Jump directly if only one result
					if #results == 1 then
						jump(results[1])
					else
						open(results)
					end
				end,
			},
		},
	},
}
