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
                require("telescope.builtin").buffers({
                    initial_mode = "normal"
                })
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
            "<leader>fr",
            function()
                require("telescope.builtin").oldfiles({
                    cwd = vim.uv.cwd(),
                    initial_mode = "normal"
                })
            end,
            desc = "Seach old files"
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
                    previewer = true,
                    initial_mode = "normal",
                    layout_config = {
                        height = 40,
                        width = 150
                    }
                })
            end,
            desc = "Open file browser with the path of the current buffer"
        },
        -- Tmux integration keybindings
        {
            "<leader>tp",
            function()
                require("akashdp.telescope.tmux").panes()
            end,
            desc = "Switch tmux panes"
        },
        {
            "<leader>ts",
            function()
                require("akashdp.telescope.tmux").sessions()
            end,
            desc = "Switch tmux sessions"
        },
        {
            "<leader>tw",
            function()
                require("akashdp.telescope.tmux").windows()
            end,
            desc = "Switch tmux windows"
        }
    },
    opts = {
        defaults = {
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    height = 40,
                    width = 150
                }
            },
            winblend = 0
        },
        extensions = {
            file_browser = {
                hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        -- Keep default mappings but don't select after create
                    },
                    ["n"] = {
                        -- Keep default mappings but don't select after create
                    }
                }
            }
        }
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")

        -- Override file browser create action to not select the file
        local fb_actions = require("telescope._extensions.file_browser.actions")
        local original_create = fb_actions.create

        fb_actions.create = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            original_create(prompt_bufnr)

            -- Return focus to telescope after file creation
            vim.schedule(function()
                if current_picker and vim.api.nvim_buf_is_valid(prompt_bufnr) then
                    local prompt_win = vim.fn.bufwinid(prompt_bufnr)
                    if prompt_win ~= -1 then
                        vim.api.nvim_set_current_win(prompt_win)
                    end
                end
            end)
        end
    end
}
