local ok, render_markdown = pcall(require, "render-markdown")
if not ok then
	return
end

render_markdown.setup({
	file_types = { "markdown", "mdx", "Avante" },
	render_modes = { "n", "c", "t" },
	heading = {
		sign = false,
	},
	code = {
		border = "thin",
		position = "right",
	},
	checkbox = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle rendered markdown" })
