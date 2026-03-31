local overrides = require("akashdp.config.overrides")

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        local opts = vim.tbl_deep_extend("force", overrides.treesitter, {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = { query = "@function.outer", desc = "Around function" },
                        ["if"] = { query = "@function.inner", desc = "Inside function" },
                        ["ac"] = { query = "@class.outer", desc = "Around class" },
                        ["ic"] = { query = "@class.inner", desc = "Inside class" },
                        ["aa"] = { query = "@parameter.outer", desc = "Around argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Inside argument" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = { query = "@function.outer", desc = "Next function start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]a"] = { query = "@parameter.inner", desc = "Next argument" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@function.outer", desc = "Next function end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                        ["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sa"] = { query = "@parameter.inner", desc = "Swap with next argument" },
                    },
                    swap_previous = {
                        ["<leader>sA"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
                    },
                },
            },
        })

        configs.setup(opts)
    end,
}
