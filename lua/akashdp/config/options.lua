-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 16
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- Font configuration (for GUI clients like neovide, nvim-qt, etc.)
if vim.g.neovide then
    vim.o.guifont = "JetBrains Mono:h14"
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_transparency = 0.9
elseif vim.g.fvim_loaded then
    vim.o.guifont = "JetBrains Mono:h14"
elseif vim.g.nvui then
    vim.o.guifont = "JetBrains Mono:h14"
else
    -- For other GUI clients
    vim.o.guifont = "JetBrains Mono:h14"
end

vim.api.nvim_set_hl(0, 'LineNr', { fg = 'yellow' })
