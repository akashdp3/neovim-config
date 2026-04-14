local function gh(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	{ src = gh("rose-pine/neovim"), name = "rose-pine" },
	{ src = gh("nvim-mini/mini.nvim") },
	{ src = gh("nvim-lua/plenary.nvim") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("folke/which-key.nvim") },
	{ src = gh("nvim-telescope/telescope.nvim") },
	{ src = gh("nvim-telescope/telescope-file-browser.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
	{ src = gh("williamboman/mason.nvim") },
	{ src = gh("williamboman/mason-lspconfig.nvim") },
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("Saghen/blink.cmp"), version = "v1.10.2" },
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("rachartier/tiny-inline-diagnostic.nvim") },
})

require("plugins.colorscheme")
require("plugins.gitsigns")
require("plugins.which-key")
require("plugins.telescope")
require("plugins.mini")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.blink")
require("plugins.conform")
