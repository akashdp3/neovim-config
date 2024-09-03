return  {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
        require("rose-pine").setup({
            disable_background = true,       -- Disables the background color
            disable_float_background = true,
            extend_background_behind_borders = true,
            styles = {
                transparency = true
            },
            highlight_groups = {
                TelescopeBorder = { fg = "highlight_high", bg = "base" },
                TelescopeNormal = { bg = "base" },
                TelescopePromptNormal = { bg = "base" },
                TelescopeResultsNormal = { fg = "subtle", bg = "base" },
                TelescopeSelection = { fg = "text", bg = "base" },
                TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
            },
        })
        vim.cmd([[colorscheme rose-pine]])
	end
}
