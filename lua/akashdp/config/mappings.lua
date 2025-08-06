local M = {}

local normal_mode_keymaps = {
    ["<leader><leader>x"] = { "<cmd>source %<CR>", "Source current file" },
    ["<leader>x"] = { ":.lua<CR>", "Source current line" },

    ["<leader>ef"] = { vim.cmd.Ex, "Open Netrw File Viewer" },

    ["<C-c>"] = { "<Esc>", "Escape" },

    ["<C-k>"] = { "<cmd>cnext<CR>zz" },
    ["<C-j>"] = { "<cmd>cprev<CR>zz" },
    ["<leader>j"] = { "<cmd>lnext<CR>zz" },
    ["<leader>k"] = { "<cmd>lprev<CR>zz" },

    ["+"] = { "<C-a>" },
    ["-"] = { "<C-x>" },

    ["dw"] = { "sv_d", "Delete a word backwards" },

    ["<C-a>"] = { "gg<S-v>G", "Select all in current buffer" },

    ["<C-m>"] = { "<C-i>", "Jumplist" },


    ["ss"] = { ":split<Return>", "Horizontal Split" },
    ["sv"] = { ":vsplit<Return>", "Vertical Split" },

    ["sh"] = { "<C-w>h", "Move to left window" },
    ["sj"] = { "<C-w>j", "Move to bottom window" },
    ["sk"] = { "<C-w>k", "Move to top window" },
    ["sl"] = { "<C-w>l", "Move to right window " },

    ["<CR>"] = { "<Plug>(neorg.esupports.hop.hop-link)", "Open link in Neorg" },

    ["<leader>yc"] = { '"+yy', "Yank current line to clipboard", "Current line copied to clipboard" },
}

local visual_mode_keymaps = {
    ["<leader>yc"] = { '"+y', "Yank selected text to clipboard", "Selected text copied to clipboard" },

    ["<leader>x"] = { ":lua<CR>", "Executes the visually selected text as Lua code" },
    
    ["J"] = { ":m '>+1<CR>gv=gv", "Move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move line up" },
}

local terminal_mode_keymaps = {
    ["<leader>tn"] = { "<c-\\><c-n>", "Sends the terminal from terminal mode to normal mode" }
}

M.general = {
    n = normal_mode_keymaps,
    v = visual_mode_keymaps,
    t = terminal_mode_keymaps
}

return M
