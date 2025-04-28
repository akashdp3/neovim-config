local M = {}

M.treesitter = {
    ensure_installed = {
        -- vim
        "lua",
        "vim",

        -- notes
        "norg",

        -- web dev
        "javascript",
        "typescript",
        "tsx",
        "go",
        "rust"
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true }
}

M.language_servers = {
    -- vim / lua
    "lua_ls",

    -- common
    "jsonls",

    -- web dev stuff
    "cssls",
    "html",
    "tsserver",
    "eslint_d",
    "prettierd",

    -- rust
    "rust_analyzer",

    -- go
    "gopls"
}

return M
