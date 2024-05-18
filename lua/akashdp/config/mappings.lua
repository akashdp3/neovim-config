local M = {}

M.general = {
    n = {
        -- Netrw file explorer
        ["<leader>ef"] = { vim.cmd.Ex, "Open Netrw File Viewer" },

        -- remap esc key to Control + c
        ["<C-c>"] = { "<Esc>", "Escape" },

        -- next and previous
        ["<C-k>"] = { "<cmd>cnext<CR>zz" },
        ["<C-j>"] = { "<cmd>cprev<CR>zz" },
        ["<leader>j"] = { "<cmd>lnext<CR>zz" },
        ["<leader>k"] = { "<cmd>lprev<CR>zz" },

        -- increment / decrement
        ["+"] = { "<C-a>" },
        ["-"] = { "<C-x>" },

        -- delete a word backwards
        ["dw"] = { "sv_d", "Delete a word backwards" },

        -- select all
        ["<C-a>"] = { "gg<S-v>G", "Select all in current buffer" },

        -- jumplist
        ["<C-m>"] = { "<C-i>", "Jumplist" },

        -- move line up and down
        ["J"] = { ":m '>+1<CR>gv=gv", "Move line down" },
        ["K"] = { ":m '<-2<CR>gv=gv", "Move line up" },

        -- split window
        ["ss"] = { ":split<Return>", "Horizontal Split" },
        ["sv"] = { ":vsplit<Return>", "Vertical Split" },

        -- move window
        ["sh"] = { "<C-w>h", "Move to left window" },
        ["sj"] = { "<C-w>j", "Move to bottom window" },
        ["sk"] = { "<C-w>k", "Move to top window" },
        ["sl"] = { "<C-w>l", "Move to right window "},

        -- telescope
        ["<leader>ff"] = {
            function()
                require("telescope.builtin").find_files({
                    no_ignore = false
                })
            end,
            "Search project files"
        },
        ["<leader>fg"] = {
            function()
                require("telescope.builtin").live_grep({})
            end,
            "Search word" 
        },
        ["<leader>fb"] = {
            function()
                require("telescope.builtin").buffers({
                    initial_mode = "normal"
                })
            end,
            "Search buffers"

        },
        ["<leader>fh"] = {
            function()
                require("telescope.builtin").help_tags()
            end,
            "Search help files"
        },
        ["<leader>fr"] = {
            function()
                require("telescope.builtin").oldfiles({
                    cwd = vim.uv.cwd(),
                    initial_mdoe = "normal"
                })
            end,
            "Search old files"
        },
        ["<leader>fd"] = {
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
            "Open file browser with the path of the current buffer"
        }

    }
}

return M
