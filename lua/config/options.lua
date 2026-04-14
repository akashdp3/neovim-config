-- Cursor configuration: blinking block cursor with different colors per mode
vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait700-blinkoff400-blinkon250",
	"i-ci-ve:block-CursorInsert/lCursor-blinkwait700-blinkoff400-blinkon250",
	"r-cr:block-CursorReplace/lCursor-blinkwait700-blinkoff400-blinkon250",
}

pcall(function()
	require("vim._core.ui2").enable()
end)

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 16
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- Cursorline for better visibility
vim.opt.cursorline = true

-- Better split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Show matching brackets
vim.opt.showmatch = true

-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- Better gf on paths like @scope/pkg and ~/foo
vim.opt.isfname:append("@-@")

-- Better completion experience
vim.opt.completeopt = "menuone,noselect,popup"
vim.opt.pumborder = "rounded"
vim.opt.pummaxwidth = 60

-- Global floating window border (applies to all floats: hover, diagnostics, etc.)
vim.opt.winborder = "rounded"

-- LSP-based folding (semantic: functions, classes, imports)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Inline char-level diff highlighting
vim.opt.diffopt:append("inline:char")

-- Confirm before closing unsaved buffers
vim.opt.confirm = true

-- Font configuration (GUI clients: neovide, nvim-qt, etc.)
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_transparency = 0.9
end
