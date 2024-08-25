return {
  "nvimdev/dashboard-nvim",
  event = 'VimEnter',
  config = function()
    require("dashboard").setup {
      theme = "hyper",
      config = {
        header = {
          '',
          '',
          '',
          '  █████╗ ██╗  ██╗ █████╗ ███████╗██╗  ██╗██████╗ ██████╗  ',
          ' ██╔══██╗██║ ██╔╝██╔══██╗██╔════╝██║  ██║██╔══██╗██╔══██╗ ',
          ' ███████║█████╔╝ ███████║███████╗███████║██║  ██║██████╔╝ ',
          ' ██╔══██║██╔═██╗ ██╔══██║╚════██║██╔══██║██║  ██║██╔═══╝  ',
          ' ██║  ██║██║  ██╗██║  ██║███████║██║  ██║██████╔╝██║      ',
          ' ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝      ',
          '',
          '',
          ''
        },
        footer = function ()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end
      }
    }
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  }
}
