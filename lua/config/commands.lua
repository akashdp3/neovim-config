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

vim.api.nvim_create_user_command("NotifyHistory", function()
	require("mini.notify").show_history()
end, { desc = "Show notification history" })

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

local function scratch_report(title, lines)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "markdown"
	vim.api.nvim_buf_set_name(buf, title)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.cmd.vsplit()
	vim.api.nvim_win_set_buf(0, buf)
end

vim.api.nvim_create_user_command("ThemeInfo", function()
	local theme = require("config.theme")
	scratch_report("ThemeInfo", {
		"# Theme",
		"",
		"- Neovim: `" .. (vim.g.colors_name or "unknown") .. "`",
		"- Configured: `" .. theme.colorscheme .. "`",
		"- Ghostty background: `" .. theme.ghostty.background .. "`",
		"- Ghostty foreground: `" .. theme.ghostty.foreground .. "`",
	})
end, { desc = "Show theme sync information" })

vim.api.nvim_create_user_command("LspInfoAll", function()
	local lines = { "# LSP clients", "" }
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		lines[#lines + 1] = "No LSP clients attached to current buffer."
	else
		for _, client in ipairs(clients) do
			lines[#lines + 1] = "- `" .. client.name .. "` root: `" .. (client.config.root_dir or "") .. "`"
		end
	end
	scratch_report("LspInfoAll", lines)
end, { desc = "Show all LSP clients for current buffer" })

vim.api.nvim_create_user_command("FormatInfo", function()
	local ok, conform = pcall(require, "conform")
	local lines = { "# Format", "" }
	if ok then
		local formatters = conform.list_formatters(0)
		for _, formatter in ipairs(formatters) do
			lines[#lines + 1] = "- `" .. formatter.name .. "`" .. (formatter.available and "" or " (missing)")
		end
	else
		lines[#lines + 1] = "conform.nvim is not available."
	end
	scratch_report("FormatInfo", lines)
end, { desc = "Show formatter information" })

vim.api.nvim_create_user_command("ConfigHealth", function()
	local lines = {
		"# Config health",
		"",
		"- colorscheme: `" .. (vim.g.colors_name or "unknown") .. "`",
		"- autoformat: `" .. (vim.g.disable_autoformat and "disabled" or "enabled") .. "`",
		"- lint: `" .. (vim.g.disable_lint and "disabled" or "enabled") .. "`",
		"- cwd: `" .. vim.uv.cwd() .. "`",
		"- filetype: `" .. vim.bo.filetype .. "`",
		"- LSP clients: `" .. #vim.lsp.get_clients({ bufnr = 0 }) .. "`",
	}
	scratch_report("ConfigHealth", lines)
end, { desc = "Show config health summary" })

vim.api.nvim_create_user_command("SessionSave", function(opts)
	local name = opts.args ~= "" and opts.args or vim.fn.fnamemodify(vim.uv.cwd(), ":t")
	require("mini.sessions").write(name, { force = true })
	vim.notify("Session saved: " .. name, vim.log.levels.INFO)
end, { nargs = "?", desc = "Save a mini.sessions session" })

local function complete_sessions()
	local dir = vim.fn.stdpath("state") .. "/sessions"
	local sessions = {}
	local fs = vim.uv.fs_scandir(dir)
	if not fs then
		return sessions
	end
	while true do
		local name, type = vim.uv.fs_scandir_next(fs)
		if not name then
			break
		end
		if type == "file" then
			sessions[#sessions + 1] = name
		end
	end
	return sessions
end

vim.api.nvim_create_user_command("SessionLoad", function(opts)
	require("mini.sessions").read(opts.args)
end, { nargs = 1, complete = complete_sessions, desc = "Load a mini.sessions session" })
