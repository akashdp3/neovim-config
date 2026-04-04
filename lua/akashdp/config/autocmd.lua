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
			vim.hl.on_yank({
				higroup = "Search",
				timeout = opts.timeout,
				on_visual = true,
			})
		end,
	})
end

function M.setup_markdown_wrapping()
	create_autocmd("FileType", {
		desc = "setup text wrapping for markdown files",
		pattern = "markdown",
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.linebreak = true
		end,
	})
end

return M
