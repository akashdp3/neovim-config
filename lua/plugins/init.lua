local function gh(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = gh("RRethy/base16-nvim") },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("nvim-telescope/telescope.nvim") },
  { src = gh("nvim-treesitter/nvim-treesitter") },
  { src = gh("echasnovski/mini.nvim") },
  { src = gh("neovim/nvim-lspconfig") },
})

require("plugins.colorscheme")
require("plugins.telescope")
