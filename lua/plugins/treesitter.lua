local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then
	return
end

local parsers = {
	"astro",
	"bash",
	"css",
	"diff",
	"html",
	"javascript",
	"json",
	"jsx",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"rust",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

treesitter.setup({})
treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)

		if pcall(vim.treesitter.get_parser, args.buf) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
