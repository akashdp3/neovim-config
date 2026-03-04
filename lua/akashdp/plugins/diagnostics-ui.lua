return {
	-- Beautiful inline diagnostics
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				options = {
					show_source = true,
					use_icons_from_diagnostic = true,
					multilines = {
						enabled = true,
						always_show = true,
					},
					show_all_diags_on_cursorline = true,
					enable_on_insert = false,
					overflow = {
						mode = "wrap",
					},
					break_line = {
						enabled = true,
						after = 80,
					},
					virt_texts = {
						priority = 2048,
					},
				},
				signs = {
					left = "",
					right = "",
					diag = "●",
					arrow = "    ",
					up_arrow = "    ",
					vertical = " │",
					vertical_end = " └",
				},
				blend = {
					factor = 0.22,
				},
			})
		end,
	},

	-- Lsp lines - show diagnostics as virtual lines (alternative view)
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		enabled = false, -- Disabled by default, enable if you prefer this style
		config = function()
			require("lsp_lines").setup()
			-- Toggle between virtual_text and lsp_lines
			vim.keymap.set("n", "<leader>xl", function()
				local new_value = not vim.diagnostic.config().virtual_lines
				vim.diagnostic.config({
					virtual_lines = new_value,
					virtual_text = not new_value,
				})
			end, { desc = "Toggle diagnostic lines" })
		end,
	},
}
