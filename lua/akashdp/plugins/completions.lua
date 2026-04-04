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
            -- Setup mason-lspconfig to install servers
            -- Server configs live in lsp/<name>.lua files (idiomatic 0.12 pattern)
            require("mason-lspconfig").setup({
                ensure_installed = overrides.language_servers,
            })

            -- Enable LSP servers (auto-starts/stops per filetype)
            vim.lsp.enable(overrides.language_servers)

            -- Native LSP features via LspAttach
            -- Keymaps are registered separately via mappings.lsp_attach
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspFeatures", {}),
                callback = function(ev)
                    local client = vim.lsp.get_clients({ id = ev.data.client_id })[1]
                    if not client then return end

                    -- Native LSP completion (0.12)
                    if client:supports_method("textDocument/completion") then
                        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                    end

                    -- Inlay hints
                    if client:supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end

                    -- Linked editing (auto-rename matching HTML/JSX tags)
                    if client:supports_method("textDocument/linkedEditingRange") then
                        vim.lsp.buf.linked_editing_range()
                    end

                    -- Codelens (virtual line hints: "Run test", "Run main", etc.)
                    if client:supports_method("textDocument/codeLens") then
                        vim.lsp.codelens.enable(true, { bufnr = ev.buf })
                    end
                end,
            })
        end,
    },
}
