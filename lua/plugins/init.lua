local function gh(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	{ src = gh("nvim-mini/mini.nvim") },
	{ src = gh("nvim-lua/plenary.nvim") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("folke/which-key.nvim") },
	{ src = gh("nvim-telescope/telescope.nvim") },
	{ src = gh("nvim-telescope/telescope-file-browser.nvim") },
	{ src = gh("epwalsh/obsidian.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
	{ src = gh("williamboman/mason.nvim") },
	{ src = gh("williamboman/mason-lspconfig.nvim") },
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("Saghen/blink.cmp"), version = "v1.10.2" },
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("rachartier/tiny-inline-diagnostic.nvim") },
	{ src = gh("nvim-neotest/nvim-nio") },
	{ src = gh("mfussenegger/nvim-dap") },
	{ src = gh("rcarriga/nvim-dap-ui") },
	{ src = gh("jay-babu/mason-nvim-dap.nvim") },
	{ src = gh("mfussenegger/nvim-lint") },
	{ src = gh("stevearc/oil.nvim") },
	{ src = gh("MeanderingProgrammer/render-markdown.nvim") },
	{ src = gh("folke/trouble.nvim") },
	{ src = gh("sindrets/diffview.nvim") },
	{ src = gh("L3MON4D3/LuaSnip") },
	{ src = gh("rafamadriz/friendly-snippets") },
})

require("plugins.colorscheme")
require("plugins.gitsigns")
require("plugins.which-key")
require("plugins.telescope")
require("plugins.oil")
require("plugins.trouble")
require("plugins.diffview")
require("plugins.markdown")
require("plugins.obsidian")
require("plugins.mini")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.snippets")
require("plugins.blink")
require("plugins.conform")
require("plugins.lint")
require("plugins.dap")
