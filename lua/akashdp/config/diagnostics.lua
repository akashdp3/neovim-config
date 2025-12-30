local M = {}

-- Configure diagnostic display
M.setup = function()
	-- Configure how diagnostics are displayed
	vim.diagnostic.config({
		-- Show diagnostic messages as virtual text at the end of the line
		virtual_text = {
			prefix = "●", -- Could be '■', '▎', 'x', '●', etc.
			spacing = 4,
			source = "if_many", -- Show source if multiple sources
		},
		-- Show diagnostic signs in the sign column (gutter)
		signs = true,
		-- Update diagnostics in insert mode (can be false for better performance)
		update_in_insert = false,
		-- Underline text with diagnostics
		underline = true,
		-- Show diagnostic messages sorted by severity
		severity_sort = true,
		-- Configure floating window appearance
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always", -- Show source in floating window
			header = "",
			prefix = "",
		},
	})

	-- Define diagnostic signs (icons in the gutter)
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end
end

-- Keybindings for diagnostics
M.setup_keymaps = function()
	local opts = { noremap = true, silent = true }

	-- Show diagnostics in a floating window
	vim.keymap.set("n", "<leader>xd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))

	-- Go to previous/next diagnostic (any severity)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

	-- Go to previous/next ERROR only
	vim.keymap.set("n", "[e", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, vim.tbl_extend("force", opts, { desc = "Previous error" }))
	vim.keymap.set("n", "]e", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, vim.tbl_extend("force", opts, { desc = "Next error" }))

	-- Go to previous/next WARNING only
	vim.keymap.set("n", "[w", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	end, vim.tbl_extend("force", opts, { desc = "Previous warning" }))
	vim.keymap.set("n", "]w", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	end, vim.tbl_extend("force", opts, { desc = "Next warning" }))

	-- Note: <leader>xx and related keys are handled by Trouble.nvim
end

-- Auto command to show diagnostic on hover (optional)
M.setup_hover = function()
	-- Show diagnostic automatically when holding cursor on a line with diagnostic
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

return M
