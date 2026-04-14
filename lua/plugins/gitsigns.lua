local ok, gitsigns = pcall(require, "gitsigns")

if not ok then
	return
end

gitsigns.setup({
	signs = {
		add = { text = "|" },
		change = { text = "|" },
		delete = { text = "|" },
		topdelete = { text = "|" },
		changedelete = { text = "|" },
		untracked = { text = "|" },
	},
	signs_staged_enable = false,
	word_diff = false,
	attach_to_untracked = true,
	current_line_blame = false,
	current_line_blame_opts = {
		delay = 250,
		virt_text_pos = "eol",
	},
	current_line_blame_formatter = " <author>, <author_time:%R> · <summary>",
	preview_config = {
		border = "rounded",
		style = "minimal",
	},
	on_attach = function(bufnr)
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true, buffer = bufnr }
		local function o(desc, extra)
			return vim.tbl_extend("force", opts, { desc = desc }, extra or {})
		end

		-- Hunk navigation
		map("n", "]h", function()
			if vim.wo.diff then
				return "]h"
			end
			vim.schedule(gitsigns.next_hunk)
			return "<Ignore>"
		end, o("Next hunk", { expr = true }))

		map("n", "[h", function()
			if vim.wo.diff then
				return "[h"
			end
			vim.schedule(gitsigns.prev_hunk)
			return "<Ignore>"
		end, o("Previous hunk", { expr = true }))

		-- Hunk text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk, o("Select hunk"))

		-- Stage / reset
		map("n", "<leader>hs", gitsigns.stage_hunk, o("Stage hunk"))
		map("n", "<leader>hr", gitsigns.reset_hunk, o("Reset hunk"))
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, o("Stage selected hunk"))
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, o("Reset selected hunk"))
		map("n", "<leader>hS", gitsigns.stage_buffer, o("Stage buffer"))
		map("n", "<leader>hR", gitsigns.reset_buffer, o("Reset buffer"))
		map("n", "<leader>hu", gitsigns.undo_stage_hunk, o("Undo stage hunk"))

		-- Inspect
		map("n", "<leader>hp", gitsigns.preview_hunk, o("Preview hunk"))
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, o("Blame line"))
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, o("Toggle line blame"))
		map("n", "<leader>hd", gitsigns.diffthis, o("Diff this"))
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end, o("Diff against previous"))
	end,
})
