local overrides = require("akashdp.config.overrides")
local config = require("akashdp.config.lspconfig")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    config = function()
        local mason = require("mason")
        local mason_lsp_config = require("mason-lspconfig")
        local lspconfig = require("lspconfig")

        mason.setup()
        mason_lsp_config.setup({
            ensure_installed = overrides.language_servers
        })

        for _, lsp in ipairs(overrides.language_servers) do
            lspconfig[lsp].setup {
                on_init = config.on_init,
                on_attach = config.on_attach,
                capabilities = config.capabilities,
            }
        end
    end
}
