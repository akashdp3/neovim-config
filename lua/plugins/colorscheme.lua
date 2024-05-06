return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
}

--return {
--  "catppuccin/nvim",
--  lazy = true,
--  name = "catppuccin",
--  priority = 1000,
-- }
