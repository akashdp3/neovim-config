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
    }
}
