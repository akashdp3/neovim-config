-- Enhanced lualine config with LSP, macro recording, and search count
local function lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return " " .. table.concat(names, ", ")
end

local function macro_recording()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "󰑋 @" .. reg
end

local function search_count()
	if vim.v.hlsearch == 0 then
		return ""
	end
	local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
	if result.total == 0 then
		return ""
	end
	return string.format(" %d/%d", result.current, result.total)
end

return {
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "dashboard", "alpha" },
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 100,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",
				symbols = { added = " ", modified = " ", removed = " " },
			},
			"diagnostics",
		},
		lualine_c = {
			{ "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" } },
			{ macro_recording, color = { fg = "#ff9e64" } },
			{ search_count, color = { fg = "#7dcfff" } },
		},
		lualine_x = {
			{ lsp_status, color = { fg = "#7aa2f7" } },
			"encoding",
			{ "fileformat", symbols = { unix = "", dos = "", mac = "" } },
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "lazy", "trouble", "quickfix" },
}

