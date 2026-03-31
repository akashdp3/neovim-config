local lualine_config = require("akashdp.config.lualine")

return {
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup(lualine_config)
		end,
	},
}
