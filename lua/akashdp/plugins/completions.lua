local overrides = require("akashdp.config.overrides")

return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- LSP (Neovim 0.12 native completion)
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            -- Native completion: show popup doc preview, don't auto-select
            vim.o.completeopt = "menuone,noinsert,noselect,popup"

            -- Bordered floating windows for hover and signature help
            local float_opts = {
                border = "rounded",
                max_width = 80,
                max_height = 20,
            }

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

            -- Global LSP settings for all servers
            vim.lsp.config("*", {
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            })

            -- Server-specific configurations
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            -- Setup mason-lspconfig to auto-enable installed servers
            require("mason-lspconfig").setup({
                ensure_installed = overrides.language_servers,
                automatic_enable = true,
            })

            -- Explicitly enable LSP servers
            vim.lsp.enable(overrides.language_servers)

            -- Native completion + inlay hints via LspAttach
            -- Keymaps are registered separately in autocmd.lua via mappings.lsp_attach
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspCompletion", {}),
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- Enable native LSP completion for this buffer (0.12)
                    if client and client.supports_method("textDocument/completion") then
                        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                    end

                    -- Enable inlay hints
                    if client and client.supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end
                end,
            })
        end,
    },
}
