local M = {}

-- Config for vim Leader and localleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Import modules
require("akashdp.config.options")
require("akashdp.config.lualine")
local autocmds = require("akashdp.config.autocmd")
local mappings = require("akashdp.config.mappings")
local diagnostics = require("akashdp.config.diagnostics")

-- Setup auto-commands
function M.setup_autocmds()
    for _, value in pairs(autocmds) do
        value()
    end
end

-- Setup config
function M.setup()
    -- mappings.lua registers global keymaps on load via vim.keymap.set
    -- Wire buffer-local LSP keymaps via LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", {}),
        callback = function(ev)
            mappings.lsp_attach(ev)
        end,
    })
    M.setup_autocmds()
    diagnostics.setup()
    diagnostics.setup_hover()
end

return M
