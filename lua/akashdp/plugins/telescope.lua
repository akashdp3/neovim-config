return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
        "nvim-telescope/telescope-file-browser.nvim"
    },
    keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files({
                    no_ignore = false
                })
            end,
            desc = "Search files"
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").live_grep({})
            end,
            desc = "Search word"
        },
        {
            "<leader>fb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Search buffers"
        },
        {
            "<leader>fh",
            function()
                require("telescope.builtin").help_tags()
            end
        },
        {
            "<leader>fd",
            function()
                local telescope = require("telescope")

                local function telescope_buffer_dir()
                    return vim.fn.expand("%:p:h")
                end

                telescope.extensions.file_browser.file_browser({
                    path = "%:p:h",
                    cwd = telescope_buffer_dir(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previwer = true,
                    initial_mode = "normal",
                    layout_config = {
                        height = 40,
                        width = 150
                    },
                })
            end,
            desc = "Open file browser with the path of the current buffer"
        }
    }
}
