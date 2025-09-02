local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

-- Function to check if we're in tmux
local function in_tmux()
    return vim.env.TMUX ~= nil
end

-- Function to execute tmux command and return output
local function tmux_command(cmd)
    local handle = io.popen("tmux " .. cmd)
    if not handle then return {} end
    
    local result = {}
    for line in handle:lines() do
        table.insert(result, line)
    end
    handle:close()
    return result
end

-- Tmux panes picker
function M.panes()
    if not in_tmux() then
        vim.notify("Not in tmux session", vim.log.levels.WARN)
        return
    end

    local panes = tmux_command("list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command} #{pane_current_path}'")
    
    pickers.new({}, {
        prompt_title = "Tmux Panes",
        finder = finders.new_table({
            results = panes,
            entry_maker = function(entry)
                local parts = vim.split(entry, " ", { plain = true })
                local pane_id = parts[1]
                local command = parts[2] or ""
                local path = parts[3] or ""
                
                return {
                    value = pane_id,
                    display = string.format("%s [%s] %s", pane_id, command, path),
                    ordinal = entry,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    vim.fn.system("tmux select-pane -t " .. selection.value)
                end
            end)
            return true
        end,
    }):find()
end

-- Tmux sessions picker
function M.sessions()
    if not in_tmux() then
        vim.notify("Not in tmux session", vim.log.levels.WARN)
        return
    end

    local sessions = tmux_command("list-sessions -F '#{session_name} #{session_windows} windows #{?session_attached,attached,not attached}'")
    
    pickers.new({}, {
        prompt_title = "Tmux Sessions",
        finder = finders.new_table({
            results = sessions,
            entry_maker = function(entry)
                local parts = vim.split(entry, " ", { plain = true })
                local session_name = parts[1]
                
                return {
                    value = session_name,
                    display = entry,
                    ordinal = entry,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    vim.fn.system("tmux switch-client -t " .. selection.value)
                end
            end)
            return true
        end,
    }):find()
end

-- Tmux windows picker
function M.windows()
    if not in_tmux() then
        vim.notify("Not in tmux session", vim.log.levels.WARN)
        return
    end

    local windows = tmux_command("list-windows -a -F '#{session_name}:#{window_index} #{window_name} #{pane_current_path}'")
    
    pickers.new({}, {
        prompt_title = "Tmux Windows",
        finder = finders.new_table({
            results = windows,
            entry_maker = function(entry)
                local parts = vim.split(entry, " ", { plain = true })
                local window_id = parts[1]
                local window_name = parts[2] or ""
                local path = parts[3] or ""
                
                return {
                    value = window_id,
                    display = string.format("%s [%s] %s", window_id, window_name, path),
                    ordinal = entry,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    vim.fn.system("tmux select-window -t " .. selection.value)
                end
            end)
            return true
        end,
    }):find()
end

return M