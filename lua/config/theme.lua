local M = {}

M.name = "catppuccin"
M.flavour = "macchiato"
M.colorscheme = "catppuccin-" .. M.flavour

-- Catppuccin Macchiato colors for Ghostty sync.
M.ghostty = {
	background = "#24273a",
	foreground = "#cad3f5",
	selection_background = "#5b6078",
	selection_foreground = "#cad3f5",
	cursor_color = "#f4dbd6",
	cursor_text = "#24273a",
}

return M
