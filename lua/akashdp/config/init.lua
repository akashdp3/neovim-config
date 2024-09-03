-- Config for vim Leader and localleader 
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Config for custom mappings
local mappings = require("akashdp.config.mappings")
local keymap = vim.keymap

for vim_mode, keymaps in pairs(mappings.general) do
    for key, value in pairs(keymaps) do
        keymap.set(vim_mode, key, value[1])
    end
end

-- Custom vim options
require("akashdp.config.options")
