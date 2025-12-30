local M = {}

local utils = require("akashdp.utils")
local create_autocmd = utils.create_autocmd
local opts_extend = utils.opts_extend

function M.highlight_on_yank(opts)
	opts = opts_extend({ timeout = 150 }, opts)
	create_autocmd("TextYankPost", {
		desc = "highlight text on yank",
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({
				higroup = "Search",
				timeout = opts.timeout,
				on_visual = true,
			})
		end,
	})
end

function M.setup_catppuccin_cursor()
	create_autocmd("ColorScheme", {
		desc = "setup catppuccin cursor colors",
		pattern = "catppuccin*",
		callback = function()
			local colors = require("catppuccin.palettes").get_palette()
			vim.api.nvim_set_hl(0, "Cursor", { bg = colors.mauve })
			vim.api.nvim_set_hl(0, "CursorInsert", { bg = colors.blue })
			vim.api.nvim_set_hl(0, "CursorReplace", { bg = colors.red })
			vim.api.nvim_set_hl(0, "Visual", { bg = colors.rosewater, fg = colors.base })
		end,
	})
end

function M.setup_norg_wrapping()
	create_autocmd("FileType", {
		desc = "setup text wrapping for norg files",
		pattern = "norg",
		callback = function()
			vim.opt_local.textwidth = 80
			vim.opt_local.wrap = true
			vim.opt_local.linebreak = true
		end,
	})
end

return M
