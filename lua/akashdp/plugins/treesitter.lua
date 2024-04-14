local overrides = require("akashdp.config.overrides")

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup(overrides.treesitter)
	end
}