local M = {}
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
map("n", "<leader><leader>x", "<cmd>source %<CR>", o("Source current file"))
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
map("n", "<leader>ef", vim.cmd.Ex, o("Open Netrw"))
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

-- ── LSP (buffer-local, registered on LspAttach) ───────────────────────────────
M.lsp_attach = function(ev)
	local opts_buf = { buffer = ev.buf }
	local function lo(desc)
		return vim.tbl_extend("force", s, opts_buf, { desc = desc })
	end

	-- Navigation
	map("n", "K", function()
		vim.lsp.buf.hover({ max_width = 80, max_height = 20 })
	end, lo("Hover documentation"))
	map("n", "gd", vim.lsp.buf.definition, lo("Go to definition"))
	map("n", "gD", vim.lsp.buf.declaration, lo("Go to declaration"))
	map("n", "gi", vim.lsp.buf.implementation, lo("Go to implementation"))
	map("n", "go", vim.lsp.buf.type_definition, lo("Go to type definition"))
	map("n", "gr", vim.lsp.buf.references, lo("Go to references"))
	map("n", "gK", function()
		vim.lsp.buf.signature_help({ max_width = 80, max_height = 20 })
	end, lo("Signature help"))
	map("i", "<C-k>", function()
		vim.lsp.buf.signature_help({ max_width = 80, max_height = 20 })
	end, lo("Signature help"))

	-- Actions
	map("n", "<F2>", vim.lsp.buf.rename, lo("Rename symbol"))
	map({ "n", "x" }, "<F3>", function()
		vim.lsp.buf.format({ async = true })
	end, lo("Format code"))
	map({ "n", "v" }, "<F4>", vim.lsp.buf.code_action, lo("Code action"))

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lo("Code action"))
	map("n", "<leader>cr", vim.lsp.buf.rename, lo("Rename symbol"))
	map({ "n", "x" }, "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, lo("Format code"))

	-- LSP lists
	map("n", "<leader>cs", vim.lsp.buf.document_symbol, lo("Document symbols"))
	map("n", "<leader>cS", vim.lsp.buf.workspace_symbol, lo("Workspace symbols"))

	-- Inlay hints toggle
	map("n", "<leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
	end, lo("Toggle inlay hints"))
end

-- ── Noice ─────────────────────────────────────────────────────────────────────
M.noice = function()
	map("c", "<S-Enter>", function()
		require("noice").redirect(vim.fn.getcmdline())
	end, o("Noice redirect cmdline"))
	map("n", "<leader>snl", function()
		require("noice").cmd("last")
	end, o("Noice last message"))
	map("n", "<leader>snh", function()
		require("noice").cmd("history")
	end, o("Noice history"))
	map("n", "<leader>sna", function()
		require("noice").cmd("all")
	end, o("Noice all messages"))
	map("n", "<leader>snd", function()
		require("noice").cmd("dismiss")
	end, o("Noice dismiss all"))
	map("n", "<leader>snt", function()
		require("noice").cmd("pick")
	end, o("Noice picker"))
	map({ "i", "n", "s" }, "<C-f>", function()
		if not require("noice.lsp").scroll(4) then
			return "<C-f>"
		end
	end, { silent = true, expr = true, desc = "Scroll forward (noice)" })
	map({ "i", "n", "s" }, "<C-b>", function()
		if not require("noice.lsp").scroll(-4) then
			return "<C-b>"
		end
	end, { silent = true, expr = true, desc = "Scroll backward (noice)" })
end

-- ── Visual ────────────────────────────────────────────────────────────────────
map("v", "<leader>x", ":lua<CR>", o("Execute selection as Lua"))
map("v", "J", ":m '>+1<CR>gv=gv", o("Move selection down"))
map("v", "K", ":m '<-2<CR>gv=gv", o("Move selection up"))

-- ── Terminal ──────────────────────────────────────────────────────────────────
map("t", "<leader>tn", "<C-\\><C-n>", o("Terminal normal mode"))

-- ── Select ────────────────────────────────────────────────────────────────────
map("x", "p", '"_dP', o("Paste without yanking"))

print("Mappings loaded")

return M
