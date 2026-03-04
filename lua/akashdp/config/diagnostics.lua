local M = {}

-- Configure diagnostic display
M.setup = function()
	-- Configure how diagnostics are displayed
	vim.diagnostic.config({
		-- Virtual text disabled - using tiny-inline-diagnostic instead for better visuals
		virtual_text = false,
		-- Show diagnostic signs in the sign column (gutter)
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = " ",
				[vim.diagnostic.severity.INFO] = " ",
			},
			linehl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
				[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
			},
			numhl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			},
		},
		-- Update diagnostics in insert mode (can be false for better performance)
		update_in_insert = false,
		-- Underline text with diagnostics
		underline = {
			severity = { min = vim.diagnostic.severity.HINT },
		},
		-- Show diagnostic messages sorted by severity
		severity_sort = true,
		-- Configure floating window appearance
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = true,
			header = " Diagnostics",
			prefix = function(diagnostic)
				local icons = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				}
				return icons[diagnostic.severity] or "● ", "DiagnosticSign" .. ({ "Error", "Warn", "Hint", "Info" })[diagnostic.severity]
			end,
			suffix = function(diagnostic)
				return diagnostic.code and string.format(" [%s]", diagnostic.code) or "", "Comment"
			end,
			format = function(diagnostic)
				return diagnostic.message
			end,
		},
	})

	-- Subtle line highlight for errors/warnings
	vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = "#2d1f1f" })
	vim.api.nvim_set_hl(0, "DiagnosticLineWarn", { bg = "#2d2a1f" })
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
