-- Create the configuration directly in the file
local function setup_claude_tmux()
        -- Function to check if we're in tmux
        local function in_tmux()
            return vim.env.TMUX ~= nil
        end

        -- Function to get current tmux session
        local function get_tmux_session()
            if not in_tmux() then return nil end
            local handle = io.popen("tmux display-message -p '#S'")
            if handle then
                local session = handle:read("*a"):gsub("\n", "")
                handle:close()
                return session
            end
            return nil
        end

        -- Function to check if Claude Code is running in any pane
        local function claude_running()
            if not in_tmux() then return false end
            local handle = io.popen("tmux list-panes -F '#{pane_current_command}' | grep -q claude && echo 'yes' || echo 'no'")
            if handle then
                local result = handle:read("*a"):gsub("\n", "")
                handle:close()
                return result == "yes"
            end
            return false
        end

        -- Function to open Claude Code in tmux split
        local function open_claude_split()
            if not in_tmux() then
                vim.notify("Not in tmux session", vim.log.levels.WARN)
                return
            end

            if claude_running() then
                -- Focus on existing Claude pane
                vim.fn.system("tmux select-pane -t $(tmux list-panes -F '#{pane_index}:#{pane_current_command}' | grep claude | cut -d: -f1 | head -1)")
            else
                -- Create new Claude split (1/4 of screen)
                vim.fn.system("tmux split-window -h -p 25 -c '" .. vim.fn.getcwd() .. "' claude")
            end
        end

        -- Function to toggle Claude Code pane
        local function toggle_claude()
            if not in_tmux() then
                vim.notify("Not in tmux session", vim.log.levels.WARN)
                return
            end

            if claude_running() then
                -- Kill Claude pane
                vim.fn.system("tmux kill-pane -t $(tmux list-panes -F '#{pane_index}:#{pane_current_command}' | grep claude | cut -d: -f1 | head -1)")
            else
                open_claude_split()
            end
        end

        -- Function to create nvim-claude session
        local function create_claude_session()
            local session_name = "nvim-claude-" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            local cmd = string.format(
                "tmux new-session -d -s '%s' -c '%s' \\; send-keys 'nvim' Enter \\; split-window -h -p 25 -c '%s' \\; send-keys 'claude' Enter \\; select-pane -L",
                session_name, vim.fn.getcwd(), vim.fn.getcwd()
            )
            vim.fn.system(cmd)
            vim.notify("Created session: " .. session_name, vim.log.levels.INFO)
        end

        -- Auto-create Claude split when opening neovim in tmux (optional)
        local auto_claude_group = vim.api.nvim_create_augroup("AutoClaude", { clear = true })
        
        -- Uncomment the following to auto-open Claude when starting neovim
        -- vim.api.nvim_create_autocmd("VimEnter", {
        --     group = auto_claude_group,
        --     callback = function()
        --         if in_tmux() and not claude_running() then
        --             vim.defer_fn(open_claude_split, 1000)  -- Delay to let neovim fully load
        --         end
        --     end,
        -- })

        -- Keybindings
        vim.keymap.set("n", "<leader>cc", open_claude_split, { desc = "Open Claude Code split" })
        vim.keymap.set("n", "<leader>ct", toggle_claude, { desc = "Toggle Claude Code pane" })
        vim.keymap.set("n", "<leader>cn", create_claude_session, { desc = "Create nvim-claude session" })

        -- Commands
        vim.api.nvim_create_user_command("ClaudeOpen", open_claude_split, { desc = "Open Claude Code in tmux split" })
        vim.api.nvim_create_user_command("ClaudeToggle", toggle_claude, { desc = "Toggle Claude Code pane" })
        vim.api.nvim_create_user_command("ClaudeSession", create_claude_session, { desc = "Create nvim-claude tmux session" })
end

-- Setup the configuration immediately
setup_claude_tmux()

-- Return empty table since this is just configuration
return {}