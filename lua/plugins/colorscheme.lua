local base16_theme = vim.env.BASE16_THEME

if base16_theme then
    vim.cmd("colorscheme base16-" .. base16_theme)
else
    vim.cmd("colorscheme base16-chalk")
end
