local M = {}

-- Config for vim Leader and localleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("akashdp.config.options")
require("akashdp.config.lualine")
local autocmds = require("akashdp.config.autocmd")
local mappings = require("akashdp.config.mappings")

function M.setup_mappings(key_mappings)
    for vim_mode, keymaps in pairs(key_mappings.general) do
        for key, value in pairs(keymaps) do
            vim.keymap.set(vim_mode, key, value[1], { desc = value[2] })
        end
    end
end

function M.setup_autocmds()
    for _, value in pairs(autocmds) do
        value()
    end
end

function M.setup()
    M.setup_mappings(mappings)
    M.setup_autocmds()
end

return M
