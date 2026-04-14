local map = vim.keymap.set
local s = { noremap = true, silent = true }
local function o(desc, extra)
	return vim.tbl_extend("force", s, { desc = desc }, extra or {})
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
map("t", "<leader>tn", "<C-\\><C-n>", o("Terminal normal mode"))

-- ── Select ────────────────────────────────────────────────────────────────────
map("x", "p", '"_dP', o("Paste without yanking"))
