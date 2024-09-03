return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    dependencies = {
      "luarocks.nvim"
    },
    config = function ()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/OneDrive\\ -\\ 7-Eleven,\\ Inc/garden"
              }
            }
          },
          -- ["core.presenter"] = {},
          -- ["core.integrations.telescope"] = {},
          -- ["core.norg.journal"] = {}
        }
      }
    end
  }
}
