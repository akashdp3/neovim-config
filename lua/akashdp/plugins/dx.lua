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
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODOs (Trouble)" },
		},
		opts = {
			focus = true,
			auto_preview = true,
			auto_refresh = true,
			auto_close = false,
			auto_jump = false,
			pinned = false,
			warn_no_results = true,
			open_no_results = false,
			win = {
				type = "split",
				position = "bottom",
				size = 10,
			},
			preview = {
				type = "split",
				relative = "win",
				position = "right",
				size = 0.4,
				scratch = true,
			},
			icons = {
				indent = {
					top = "│ ",
					middle = "├╴",
					last = "└╴",
					fold_open = " ",
					fold_closed = " ",
					ws = "  ",
				},
				folder_closed = " ",
				folder_open = " ",
				kinds = {
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					String = " ",
					Struct = "󰆼 ",
					TypeParameter = " ",
					Variable = "󰀫 ",
				},
			},
			modes = {
				symbols = {
					win = { position = "right", size = 40 },
				},
				diagnostics = {
					groups = {
						{ "filename", format = "{file_icon} {basename:Title} {count}" },
					},
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
