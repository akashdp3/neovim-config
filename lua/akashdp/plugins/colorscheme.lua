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

        -- Highlight current line
        vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#6e6a86' })
        vim.api.nvim_set_hl(0, 'LineNr', { fg='#eb6f92', bold=true })
        vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#6e6a86' })
	end
}
