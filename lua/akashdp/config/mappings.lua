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

    -- Window splits
    ["ss"] = { ":split<Return>", "Horizontal Split" },
    ["sv"] = { ":vsplit<Return>", "Vertical Split" },

    -- Window navigation (ergonomic)
    ["<C-h>"] = { "<C-w>h", "Move to left window" },
    ["<C-l>"] = { "<C-w>l", "Move to right window" },
    ["sh"] = { "<C-w>h", "Move to left window" },
    ["sj"] = { "<C-w>j", "Move to bottom window" },
    ["sk"] = { "<C-w>k", "Move to top window" },
    ["sl"] = { "<C-w>l", "Move to right window " },

    -- Window resize
    ["<C-Up>"] = { "<cmd>resize +2<CR>", "Increase window height" },
    ["<C-Down>"] = { "<cmd>resize -2<CR>", "Decrease window height" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<CR>", "Decrease window width" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<CR>", "Increase window width" },
    ["<leader>wm"] = { "<cmd>only<CR>", "Maximize window (close others)" },
    ["<leader>we"] = { "<C-w>=", "Equalize window sizes" },

    -- Line operations
    ["<A-j>"] = { "<cmd>m .+1<CR>==", "Move line down" },
    ["<A-k>"] = { "<cmd>m .-2<CR>==", "Move line up" },
    ["<leader>o"] = { "o<Esc>", "Insert blank line below" },
    ["<leader>O"] = { "O<Esc>", "Insert blank line above" },

    -- Quick save/quit
    ["<leader>fs"] = { "<cmd>w<CR>", "Save file" },
    ["<leader>q"] = { "<cmd>q<CR>", "Quit" },
    ["<leader>Q"] = { "<cmd>qa!<CR>", "Force quit all" },

    -- Better scrolling (centered)
    ["<C-d>"] = { "<C-d>zz", "Scroll down (centered)" },
    ["<C-u>"] = { "<C-u>zz", "Scroll up (centered)" },
    ["n"] = { "nzzzv", "Next search result (centered)" },
    ["N"] = { "Nzzzv", "Prev search result (centered)" },

    -- Join lines without moving cursor
    ["J"] = { "mzJ`z", "Join lines (keep cursor)" },

    ["<CR>"] = { "<Plug>(neorg.esupports.hop.hop-link)", "Open link in Neorg" },

    ["yc"] = { '"+yy', "Yank current line to clipboard", "Current line copied to clipboard" },
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

local select_mode_keymaps = {
    ["p"] = { '"_dP', "Paste without yanking" }
}

M.general = {
    n = normal_mode_keymaps,
    v = visual_mode_keymaps,
    t = terminal_mode_keymaps,
    x = select_mode_keymaps,
}

return M
