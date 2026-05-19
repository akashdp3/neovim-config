local theme = require("config.theme")

local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
	return
end

catppuccin.setup({
	flavour = theme.flavour,
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	term_colors = true,
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
	},
})

vim.cmd.colorscheme(theme.colorscheme)
