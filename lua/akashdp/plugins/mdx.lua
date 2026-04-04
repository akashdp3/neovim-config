return {
    -- Manual MDX support (compatibility with Neovim 0.12.0)
    dir = vim.fn.stdpath("config"),
    name = "mdx-support",
    lazy = false,
    config = function()
        -- Register mdx as its own filetype
        vim.filetype.add({
            extension = {
                mdx = "mdx",
            },
        })

        -- Use markdown syntax highlighting (vim builtin) without treesitter
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "mdx",
            callback = function(args)
                vim.bo[args.buf].syntax = "markdown"
                -- Stop treesitter highlighting for this buffer
                vim.treesitter.stop(args.buf)
            end,
        })

        -- Detach ts_ls from mdx buffers
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_clients({ id = args.data.client_id })[1]
                if client and client.name == "ts_ls" and vim.bo[args.buf].filetype == "mdx" then
                    vim.lsp.buf_detach_client(args.buf, client.id)
                end
            end,
        })
    end,
}
