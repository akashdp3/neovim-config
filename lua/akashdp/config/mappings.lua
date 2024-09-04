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

        -- Neorg
        ["<CR>"] = { "<Plug>(neorg.esupports.hop.hop-link)", "Open link in Neorg" }
    }
}

return M
