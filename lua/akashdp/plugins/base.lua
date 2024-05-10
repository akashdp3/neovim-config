-- local mappings = require("akashdp.config.mappings");

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
    },

    -- which-key config
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    }
}
