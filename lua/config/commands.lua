local function toggle_buffer_autoformat()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
	vim.notify(
		vim.b.disable_autoformat and "Autoformat disabled for buffer" or "Autoformat enabled for buffer",
		vim.log.levels.INFO
	)
end

local function toggle_global_autoformat()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	vim.notify(
		vim.g.disable_autoformat and "Autoformat disabled globally" or "Autoformat enabled globally",
		vim.log.levels.INFO
	)
end

local function toggle_virtual_text()
	local config = vim.diagnostic.config()
	local enabled = config.virtual_text ~= false
	vim.diagnostic.config({ virtual_text = not enabled })
	vim.notify(
		enabled and "Diagnostic virtual text disabled" or "Diagnostic virtual text enabled",
		vim.log.levels.INFO
	)
end

local function toggle_inlay_hints()
	local bufnr = vim.api.nvim_get_current_buf()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
	vim.notify(
		enabled and "Inlay hints disabled" or "Inlay hints enabled",
		vim.log.levels.INFO
	)
end

vim.api.nvim_create_user_command("Format", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format current buffer" })

vim.api.nvim_create_user_command("FormatToggle", toggle_buffer_autoformat, {
	desc = "Toggle autoformat for current buffer",
})

vim.api.nvim_create_user_command("FormatToggleGlobal", toggle_global_autoformat, {
	desc = "Toggle autoformat globally",
})

vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", toggle_virtual_text, {
	desc = "Toggle diagnostic virtual text",
})

vim.api.nvim_create_user_command("InlayHintsToggle", toggle_inlay_hints, {
	desc = "Toggle inlay hints for current buffer",
})

vim.api.nvim_create_user_command("LspRestartAll", function()
	vim.lsp.stop_client(vim.lsp.get_clients())
	vim.cmd("edit")
end, { desc = "Restart all LSP clients for current session" })

vim.api.nvim_create_user_command("DapClearBreakpoints", function()
	require("nvim-dap").clear_breakpoints()
	vim.notify("All breakpoints cleared", vim.log.levels.INFO)
end, { desc = "Clear all DAP breakpoints" })

vim.api.nvim_create_user_command("DapUIToggle", function()
	require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
