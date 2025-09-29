local M = {}

M.treesitter = {
    ensure_installed = {
        -- vim
        "lua",
        "vim",

        -- notes
        "norg",

        -- config files
        "yaml",

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
    "ts_ls",

    -- rust
    "rust_analyzer",

    -- go
    "gopls"
}

M.formatters_linters = {
    -- web dev
    "eslint_d",
    "prettierd",
    
    -- lua
    "stylua",
    
    -- go
    "gofumpt",
    "goimports",
    
    -- rust
    "rustfmt",
}

M.mason = {}

return M
