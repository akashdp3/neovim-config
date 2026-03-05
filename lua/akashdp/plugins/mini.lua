return {
	-- mini.bufremove for better buffer deletion
	{
		"echasnovski/mini.bufremove",
		version = "*",
		keys = {
			{ "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete buffer" },
			{ "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete buffer (force)" },
		},
	},
	-- mini.animate for smooth scrolling and animations
	{
		"echasnovski/mini.animate",
		version = "*",
		event = "VeryLazy",
		opts = function()
			local animate = require("mini.animate")
			return {
				cursor = {
					enable = true,
					timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
				},
				scroll = {
					enable = true,
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				resize = {
					enable = true,
					timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
				},
				open = { enable = false },
				close = { enable = false },
			}
		end,
	},
	-- mini.pairs for auto-closing brackets
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "InsertEnter",
		opts = {},
	},
	-- mini.surround for surround operations (bonus)
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "gsa",            -- Add surrounding in Normal and Visual modes
				delete = "gsd",         -- Delete surrounding
				find = "gsf",           -- Find surrounding (to the right)
				find_left = "gsF",      -- Find surrounding (to the left)
				highlight = "gsh",      -- Highlight surrounding
				replace = "gsr",        -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
}
