return {
    {
        "nvim-lua/plenary.nvim"
    },
    {
        "numToStr/Comment.nvim",
        config = function(_, opts)
            require("Comment").setup(opts)
        end
    },
    {
        "editorconfig/editorconfig-vim"
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                options = { theme = "horizon"  }
            })
        end
    }
}
