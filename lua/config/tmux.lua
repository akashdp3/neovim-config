local M = {}

local tmux_direction = {
	h = "L",
	j = "D",
	k = "U",
	l = "R",
}

local function in_tmux()
	return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
end

local function select_tmux_pane(direction)
	if not in_tmux() then
		return
	end

	vim.system({ "tmux", "select-pane", "-" .. direction }, { detach = true })
end

function M.navigate(key)
	local before = vim.api.nvim_get_current_win()
	vim.cmd.wincmd(key)

	-- If Neovim could not move, hand the navigation to tmux.
	if before == vim.api.nvim_get_current_win() then
		select_tmux_pane(tmux_direction[key])
	end
end

return M
