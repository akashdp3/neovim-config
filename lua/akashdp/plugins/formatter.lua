return {
    'stevearc/conform.nvim',
    config = function()
        require('conform').setup {
            formatters_by_ft = {
                lua = { "stylua" },
                vue = { "prettierd" },
                html = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                json = { "prettierd" },
                markdown = { "prettierd" },
                yaml = { "prettierd" },
                toml = { "prettierd" },
                sql = { "sql_formatter" },
                rust = { "rustfmt" },
                go = { "gofmt" },
                sh = { "shfmt" },
                astro = { "prettierd" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback"
            }
        }
    end
}
