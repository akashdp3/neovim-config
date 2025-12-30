return {
	"RRethy/base16-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- RRethy/base16-nvim doesn't need setup() - just set the colorscheme directly

		-- Sync with base16-shell
		local base16_theme = vim.env.BASE16_THEME
		if base16_theme then
			vim.cmd("colorscheme base16-" .. base16_theme)
		else
			-- Fallback
			vim.cmd("colorscheme base16-gruvbox-dark-hard")
		end
	end,
}
