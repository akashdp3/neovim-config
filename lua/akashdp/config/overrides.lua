local M = {}

M.treesitter = {
    ensure_installed = {
        -- vim
        "lua",
        "vim",

        -- web dev
        "javascript",
        "typescript",
        "tsx",

        -- others
        "rust"
    },
    sync_install = false,
    highlight = { enable = true  },
    indent = { enable = true  }
}

M.language_servers = {
    -- vim / lua
    "lua_ls",

    -- common
    "jsonls",
    "eslint",

    -- web dev stuff
    "cssls",
    "html",
    "tailwindcss",
    "tsserver",

    -- others
    "rust_analyzer"
}

return M
