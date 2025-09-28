-- return {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("rose-pine").setup({
--             disable_background = true, -- Disables the background color
--             disable_float_background = true,
--             extend_background_behind_borders = true,
--             styles = {
--                 transparency = true
--             },
--             highlight_groups = {
--                 TelescopeBorder = { fg = "highlight_high", bg = "base" },
--                 TelescopeNormal = { bg = "base" },
--                 TelescopePromptNormal = { bg = "base" },
--                 TelescopeResultsNormal = { fg = "subtle", bg = "base" },
--                 TelescopeSelection = { fg = "text", bg = "base" },
--                 TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
--             },
--         })
--         vim.cmd([[colorscheme rose-pine]])
--
--         -- Highlight current line
--         vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#6e6a86' })
--         vim.api.nvim_set_hl(0, 'LineNr', { fg = '#eb6f92', bold = true })
--         vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#6e6a86' })
--     end
-- }
--
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "macchiato",
			},
			transparent_background = true,
			show_end_of_buffer = false, -- show the '~' characters after the end of buffers
			term_colors = false,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = {
				LineNrAbove = { fg = "#6e6a86" },
				LineNr = { fg = "#eb6f92", bold = true },
				LineNrBelow = { fg = "#6e6a86" },
			},
			auto_integrations = true,
		})

		vim.cmd([[colorscheme catppuccin]])
	end,
}
