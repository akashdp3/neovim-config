local map = vim.keymap.set
local s = { noremap = true, silent = true }
local function o(desc, extra)
	return vim.tbl_extend("force", s, { desc = desc }, extra or {})
end

--- Floating :term lazygit (no plugin). q / Esc close from Terminal-Normal (<C-\\><C-n>).
local function open_lazygit_float()
	local buf = vim.api.nvim_create_buf(false, true)
	local vw = vim.o.columns
	local vv = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus ~= 0 and 1 or 0)
	local width = math.max(40, math.min(math.floor(vw * 0.92), vw - 2))
	local height = math.max(15, math.min(math.floor(vv * 0.92), vv - 2))
	local row = math.max(0, math.floor((vv - height) / 2))
	local col = math.max(0, math.floor((vw - width) / 2))

	local closed = false
	local win

	local function shutdown()
		if closed then
			return
		end
		closed = true
		if win and vim.api.nvim_win_is_valid(win) then
			pcall(vim.api.nvim_win_close, win, true)
		end
		if buf and vim.api.nvim_buf_is_valid(buf) then
			pcall(vim.api.nvim_buf_delete, buf, { force = true })
		end
	end

	win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " lazygit ",
		title_pos = "center",
		zindex = 50,
	})

	-- Terminal-Normal uses Normal-mode maps; buffer-local so only this float.
	vim.keymap.set("n", "q", shutdown, { buffer = buf, silent = true })
	vim.keymap.set("n", "<Esc>", shutdown, { buffer = buf, silent = true })

	vim.api.nvim_set_current_buf(buf)
	vim.fn.termopen("lazygit", {
		cwd = vim.fn.getcwd(0),
		on_exit = function()
			vim.schedule(shutdown)
		end,
	})
	vim.cmd.startinsert()
end

-- ── General ───────────────────────────────────────────────────────────────────
map("n", "<C-c>", "<Esc>", o("Escape"))
map("n", "<C-a>", "gg<S-v>G", o("Select all"))
map("n", "<C-m>", "<C-i>", o("Jumplist forward"))
map("n", "+", "<C-a>", o("Increment number"))
map("n", "-", "<C-x>", o("Decrement number"))
map("n", "dw", "vbd", o("Delete word backwards"))
map("n", "J", "mzJ`z", o("Join lines (keep cursor)"))
map("n", "<leader><leader>x", "<cmd>luafile %<CR>", o("Source current file"))
map("n", "<leader><leader>r", "<cmd>restart<CR>", o("Restart Neovim"))
map("n", "<leader>x", ":.lua<CR>", o("Execute line as Lua"))

-- ── Scrolling ─────────────────────────────────────────────────────────────────
map("n", "<C-d>", "<C-d>zz", o("Scroll down (centered)"))
map("n", "<C-u>", "<C-u>zz", o("Scroll up (centered)"))
map("n", "n", "nzzzv", o("Next search result (centered)"))
map("n", "N", "Nzzzv", o("Prev search result (centered)"))

-- ── Quickfix / Location list ──────────────────────────────────────────────────
map("n", "<C-k>", "<cmd>cnext<CR>zz", o("Quickfix next"))
map("n", "<C-j>", "<cmd>cprev<CR>zz", o("Quickfix prev"))
map("n", "<leader>j", "<cmd>lnext<CR>zz", o("Loclist next"))
map("n", "<leader>k", "<cmd>lprev<CR>zz", o("Loclist prev"))

-- ── Window splits ─────────────────────────────────────────────────────────────
map("n", "ss", ":split<Return>", o("Horizontal split"))
map("n", "sv", ":vsplit<Return>", o("Vertical split"))

-- ── Window navigation ─────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", o("Move to left window"))
map("n", "<C-l>", "<C-w>l", o("Move to right window"))
map("n", "sh", "<C-w>h", o("Move to left window"))
map("n", "sj", "<C-w>j", o("Move to bottom window"))
map("n", "sk", "<C-w>k", o("Move to top window"))
map("n", "sl", "<C-w>l", o("Move to right window"))

-- ── Window resize ─────────────────────────────────────────────────────────────
map("n", "<C-Up>", "<cmd>resize +2<CR>", o("Increase window height"))
map("n", "<C-Down>", "<cmd>resize -2<CR>", o("Decrease window height"))
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", o("Decrease window width"))
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", o("Increase window width"))
map("n", "<leader>wm", "<cmd>only<CR>", o("Maximize window"))
map("n", "<leader>we", "<C-w>=", o("Equalize window sizes"))

-- ── Line operations ───────────────────────────────────────────────────────────
map("n", "<A-j>", "<cmd>m .+1<CR>==", o("Move line down"))
map("n", "<A-k>", "<cmd>m .-2<CR>==", o("Move line up"))
map("n", "<leader>o", "o<Esc>", o("Blank line below"))
map("n", "<leader>O", "O<Esc>", o("Blank line above"))

-- ── File / Save / Quit ────────────────────────────────────────────────────────
map("n", "<leader>fs", "<cmd>w ++p<CR>", o("Save file (auto-create dirs)"))
map("n", "<leader>q", "<cmd>q<CR>", o("Quit"))
map("n", "<leader>Q", "<cmd>qa!<CR>", o("Force quit all"))

-- ── Undotree (native 0.12) ────────────────────────────────────────────────────
vim.cmd("packadd nvim.undotree")
map("n", "<leader>u", require("undotree").open, o("Toggle Undotree"))

-- ── Diagnostics ───────────────────────────────────────────────────────────────
map("n", "<leader>xd", vim.diagnostic.open_float, o("Show diagnostic float"))
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, o("Previous diagnostic"))
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, o("Next diagnostic"))
map("n", "[e", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
end, o("Previous error"))
map("n", "]e", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
end, o("Next error"))
map("n", "[w", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.WARN })
end, o("Previous warning"))
map("n", "]w", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.WARN })
end, o("Next warning"))

map("n", "<leader>xx", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, o("Diagnostics (qflist)"))
map("n", "<leader>xX", function()
	vim.diagnostic.setloclist()
end, o("Buffer diagnostics (loclist)"))
map("n", "<leader>xL", "<cmd>lopen<CR>", o("Location list"))
map("n", "<leader>xQ", "<cmd>copen<CR>", o("Quickfix list"))

-- ── Visual ────────────────────────────────────────────────────────────────────
map("v", "<leader>x", ":lua<CR>", o("Execute selection as Lua"))
map("v", "J", ":m '>+1<CR>gv=gv", o("Move selection down"))
map("v", "K", ":m '<-2<CR>gv=gv", o("Move selection up"))

-- ── Terminal ──────────────────────────────────────────────────────────────────
map("n", "<leader>lg", open_lazygit_float, o("Lazygit"))
map("t", "<leader>tn", "<C-\\><C-n>", o("Terminal normal mode"))

-- ── Select ────────────────────────────────────────────────────────────────────
map("x", "p", '"_dP', o("Paste without yanking"))
