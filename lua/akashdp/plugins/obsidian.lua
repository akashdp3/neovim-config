return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>nn", "<cmd>ObsidianNew<cr>",         desc = "New note" },
            { "<leader>no", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
            { "<leader>ns", "<cmd>ObsidianSearch<cr>",      desc = "Search notes" },
            { "<leader>nt", "<cmd>ObsidianToday<cr>",       desc = "Today's journal" },
            { "<leader>ny", "<cmd>ObsidianYesterday<cr>",   desc = "Yesterday's journal" },
            { "<leader>nm", "<cmd>ObsidianTomorrow<cr>",    desc = "Tomorrow's journal" },
            { "<leader>nb", "<cmd>ObsidianBacklinks<cr>",   desc = "Backlinks" },
            { "<leader>nl", "<cmd>ObsidianLinks<cr>",       desc = "Links" },
            { "<leader>ni", "<cmd>ObsidianTemplate<cr>",    desc = "Insert template" },
            { "<leader>nf", "<cmd>ObsidianFollowLink<cr>",  desc = "Follow link" },
            { "<leader>nr", "<cmd>ObsidianRename<cr>",      desc = "Rename note" },
            { "<leader>nT", "<cmd>ObsidianTags<cr>",        desc = "Browse tags" },
        },
        opts = {
            workspaces = {
                {
                    name = "notes",
                    path = "~/Code/notes",
                },
            },
            templates = {
                folder = "Templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
            },
            daily_notes = {
                folder = "00-Inbox/01-Journal",
                date_format = "%Y-%m-%d",
                template = "daily.md",
            },
            new_notes_location = "current_dir",
            completion = {
                nvim_cmp = false,
                min_chars = 2,
            },
            ui = {
                enable = true,
                checkboxes = {
                    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                    ["-"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                },
            },
            follow_url_func = function(url)
                vim.fn.jobstart({ "open", url })
            end,
        },
    },
}
