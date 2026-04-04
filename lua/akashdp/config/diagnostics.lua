local M = {}

-- Configure diagnostic display
M.setup = function()
	-- Configure how diagnostics are displayed
	vim.diagnostic.config({
		-- Native inline diagnostics (virtual_lines, 0.11+)
		virtual_text = {
			prefix = "●",
			format = function(d)
				local msg = d.message:gsub("\n", " ")
				if #msg > 60 then msg = msg:sub(1, 57) .. "..." end
				return msg
			end,
			severity = { min = vim.diagnostic.severity.HINT },
		},
		virtual_lines = false,
		-- Show diagnostic signs in the sign column (gutter)
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = " ",
				[vim.diagnostic.severity.INFO] = " ",
			},
			numhl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
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

end

-- Auto command to show diagnostic on hover (optional)
M.setup_hover = function()
	-- Show diagnostic automatically when holding cursor on a line with diagnostic
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
		local opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			source = true,
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(opts)
		end,
	})
end

return M
