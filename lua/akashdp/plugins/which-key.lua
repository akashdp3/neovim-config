return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			preset = "modern",
			delay = 200, -- Show popup faster
			icons = {
				breadcrumb = "»",
				separator = "→",
				group = "+",
				mappings = true, -- Enable mini.icons integration if available
				keys = {
					Up = " ",
					Down = " ",
					Left = " ",
					Right = " ",
					C = "󰘴 ",
					M = "󰘵 ",
					D = "󰘳 ",
					S = "󰘶 ",
					CR = "󰌑 ",
					Esc = "󱊷 ",
					ScrollWheelDown = "󱕐 ",
					ScrollWheelUp = "󱕑 ",
					NL = "󰌑 ",
					BS = "󰁮 ",
					Space = "󱁐 ",
					Tab = "󰌒 ",
					F1 = "󱊫",
					F2 = "󱊬",
					F3 = "󱊭",
					F4 = "󱊮",
					F5 = "󱊯",
					F6 = "󱊰",
					F7 = "󱊱",
					F8 = "󱊲",
					F9 = "󱊳",
					F10 = "󱊴",
					F11 = "󱊵",
					F12 = "󱊶",
				},
			},
			win = {
				border = "rounded",
				padding = { 1, 2 },
				title = true,
				title_pos = "center",
			},
			layout = {
				width = { min = 20, max = 50 },
				spacing = 3,
			},
			spec = {
				-- Top-level groups with icons
				{ "<leader>f", group = "󰈞 Find/Files", icon = "󰈞" },
				{ "<leader>e", group = "󰙅 Explorer", icon = "󰙅" },
				{ "<leader>g", group = " Git", icon = "" },
				{ "<leader>l", group = " LSP", icon = "" },
				{ "<leader>t", group = " Terminal/Tmux", icon = "" },
				{ "<leader>w", group = "󰖯 Window", icon = "󰖯" },
				{ "<leader>b", group = "󰓩 Buffer", icon = "󰓩" },
				{ "<leader>y", group = " Yank/Copy", icon = "" },
				{ "<leader>c", group = " Code/Claude", icon = "" },
				{ "<leader>d", group = " Debug", icon = "" },
				{ "<leader>r", group = " Replace", icon = "" },
				{ "<leader>s", group = "󰛔 Search/Noice", icon = "󰛔" },
				{ "<leader>x", group = "󱍼 Diagnostics", icon = "󱍼" },
				{ "<leader>h", group = "󱡀 Harpoon", icon = "󱡀" },
				{ "<leader>a", group = "󰚩 AI", icon = "󰚩" },
				{ "<leader>i", group = " Info/Inspect", icon = "" },

				-- Find/Files
				{ "<leader>ff", desc = "Find files", icon = "󰈞" },
				{ "<leader>fg", desc = "Live grep", icon = "󰊄" },
				{ "<leader>fb", desc = "Find buffers", icon = "󰓩" },
				{ "<leader>fh", desc = "Help tags", icon = "󰋖" },
				{ "<leader>fr", desc = "Recent files", icon = "󰋚" },
				{ "<leader>fd", desc = "File browser", icon = "󰙅" },
				{ "<leader>fs", desc = "Save file", icon = "󰆓" },

				-- Terminal/Tmux
				{ "<leader>tp", desc = "Switch tmux panes", icon = "󰓫" },
				{ "<leader>ts", desc = "Switch tmux sessions", icon = "󱂬" },
				{ "<leader>tw", desc = "Switch tmux windows", icon = "󰖯" },
				{ "<leader>tn", desc = "Terminal normal mode", icon = "" },

				-- Window
				{ "<leader>wm", desc = "Maximize (close others)", icon = "󰁌" },
				{ "<leader>we", desc = "Equalize sizes", icon = "󰕭" },

				-- Buffer
				{ "<leader>bd", desc = "Delete buffer", icon = "󰅖" },
				{ "<leader>bD", desc = "Delete buffer (force)", icon = "󰅗" },
				{ "<leader>bo", desc = "Close other buffers", icon = "󰱝" },
				{ "<leader>bp", desc = "Pin buffer", icon = "󰐃" },
				{ "<leader>bP", desc = "Close unpinned", icon = "󰤱" },
				{ "<leader>bl", desc = "Close buffers right", icon = "󰁔" },
				{ "<leader>bh", desc = "Close buffers left", icon = "󰁍" },

				-- Code/Claude
				{ "<leader>cc", desc = "Open Claude split", icon = "󰚩" },
				{ "<leader>ct", desc = "Toggle Claude pane", icon = "󰘖" },
				{ "<leader>cn", desc = "New Claude session", icon = "󰝒" },
				{ "<leader>cs", desc = "Symbols (Trouble)", icon = "󰅪" },
				{ "<leader>cS", desc = "LSP refs/defs", icon = "󰁨" },

				-- Diagnostics/Quickfix
				{ "<leader>xd", desc = "Show diagnostic float", icon = "󰙨" },
				{ "<leader>xx", desc = "Diagnostics (Trouble)", icon = "󱍼" },
				{ "<leader>xX", desc = "Buffer diagnostics", icon = "󰈙" },
				{ "<leader>xL", desc = "Location list", icon = "󰆤" },
				{ "<leader>xQ", desc = "Quickfix list", icon = "󰁨" },
				{ "<leader>xq", desc = "Telescope quickfix", icon = "󰈞" },
				{ "<leader>xl", desc = "Telescope loclist", icon = "󰈞" },
				{ "<leader>xw", desc = "Workspace diagnostics", icon = "󰒋" },
				{ "<leader>xt", desc = "TODOs (Trouble)", icon = "󰄬" },

				-- Harpoon
				{ "<leader>ha", desc = "Add file", icon = "󰐕" },
				{ "<leader>hh", desc = "Quick menu", icon = "󱡀" },
				{ "<leader>h1", desc = "File 1", icon = "󰎤" },
				{ "<leader>h2", desc = "File 2", icon = "󰎧" },
				{ "<leader>h3", desc = "File 3", icon = "󰎪" },
				{ "<leader>h4", desc = "File 4", icon = "󰎭" },
				{ "<leader>hn", desc = "Next file", icon = "󰒭" },
				{ "<leader>hp", desc = "Previous file", icon = "󰒮" },

				-- Search/Noice
				{ "<leader>sn", group = "󰎟 Noice", icon = "󰎟" },
				{ "<leader>snl", desc = "Last message", icon = "󰋚" },
				{ "<leader>snh", desc = "History", icon = "󰋖" },
				{ "<leader>sna", desc = "All messages", icon = "󰍡" },
				{ "<leader>snd", desc = "Dismiss all", icon = "󰅖" },
				{ "<leader>snt", desc = "Noice picker", icon = "󰈞" },

				-- Quick actions (no group)
				{ "<leader>u", desc = "Toggle Undotree", icon = "󰕌" },
				{ "<leader>o", desc = "Blank line below", icon = "󰁅" },
				{ "<leader>O", desc = "Blank line above", icon = "󰁝" },
				{ "<leader>q", desc = "Quit", icon = "󰈆" },
				{ "<leader>Q", desc = "Force quit all", icon = "󰗼" },
				{ "<leader>ih", desc = "Toggle inlay hints", icon = "󰌵" },

				-- Source/Execute
				{ "<leader><leader>x", desc = "Source current file", icon = "󰑓" },
				{ "<leader>x", desc = "Execute line as Lua", icon = "" },

				-- Yank
				{ "yc", desc = "Yank line to clipboard", icon = "" },
				{ "<leader>yc", desc = "Yank selection to clipboard", icon = "", mode = "v" },

				-- Goto group
				{ "g", group = " Goto", icon = "" },
				{ "gd", desc = "Definition", icon = "󰈮" },
				{ "gD", desc = "Peek definitions", icon = "󰍉" },
				{ "gi", desc = "Implementation", icon = "󰡱" },
				{ "gr", desc = "References", icon = "󰈇" },
				{ "gR", desc = "Peek references", icon = "󰍉" },
				{ "gY", desc = "Peek type defs", icon = "󰍉" },
				{ "gM", desc = "Peek implementations", icon = "󰍉" },
				{ "go", desc = "Type definition", icon = "󰊄" },
				{ "gs", desc = "Signature help", icon = "󰏪" },

				-- Surround (mini.surround)
				{ "gs", group = "󰅪 Surround", icon = "󰅪" },
				{ "gsa", desc = "Add surrounding", icon = "󰐕" },
				{ "gsd", desc = "Delete surrounding", icon = "󰅖" },
				{ "gsr", desc = "Replace surrounding", icon = "󰏫" },
				{ "gsf", desc = "Find surrounding", icon = "󰈞" },
				{ "gsF", desc = "Find surrounding (left)", icon = "󰈞" },
				{ "gsh", desc = "Highlight surrounding", icon = "󰸱" },
				{ "gsn", desc = "Update n_lines", icon = "󰎠" },

				-- Flash
				{ "s", desc = "Flash jump", icon = "󰉁" },
				{ "S", desc = "Flash treesitter", icon = "󰐅" },

				-- Folds
				{ "z", group = "󰘖 Fold", icon = "󰘖" },
				{ "za", desc = "Toggle fold", icon = "󰘖" },
				{ "zA", desc = "Toggle all folds", icon = "󰘖" },
				{ "zc", desc = "Close fold", icon = "󰁂" },
				{ "zC", desc = "Close all folds", icon = "󰁂" },
				{ "zo", desc = "Open fold", icon = "󰁃" },
				{ "zO", desc = "Open all folds", icon = "󰁃" },
				{ "zM", desc = "Close all", icon = "󰁂" },
				{ "zR", desc = "Open all", icon = "󰁃" },

				-- Next/Prev navigation
				{ "]", group = "󰒭 Next", icon = "󰒭" },
				{ "]d", desc = "Next diagnostic", icon = "󱍼" },
				{ "]e", desc = "Next error", icon = "" },
				{ "]w", desc = "Next warning", icon = "" },
				{ "]h", desc = "Next hunk", icon = "" },
				{ "]b", desc = "Next buffer", icon = "󰓩" },

				{ "[", group = "󰒮 Previous", icon = "󰒮" },
				{ "[d", desc = "Previous diagnostic", icon = "󱍼" },
				{ "[e", desc = "Previous error", icon = "" },
				{ "[w", desc = "Previous warning", icon = "" },
				{ "[h", desc = "Previous hunk", icon = "" },
				{ "[b", desc = "Previous buffer", icon = "󰓩" },

				-- Buffer navigation (number keys)
				{ "<leader>1", desc = "Buffer 1", icon = "󰎤" },
				{ "<leader>2", desc = "Buffer 2", icon = "󰎧" },
				{ "<leader>3", desc = "Buffer 3", icon = "󰎪" },
				{ "<leader>4", desc = "Buffer 4", icon = "󰎭" },
				{ "<leader>5", desc = "Buffer 5", icon = "󰎱" },

				-- LSP specific (shown in LspAttach)
				{ "K", desc = "Hover documentation", icon = "󰋖" },
				{ "<F2>", desc = "Rename symbol", icon = "󰏫" },
				{ "<F3>", desc = "Format code", icon = "󰉢" },
				{ "<F4>", desc = "Code action", icon = "󰌵" },

				-- Window splits
				{ "ss", desc = "Horizontal split", icon = "󰇘" },
				{ "sv", desc = "Vertical split", icon = "󰇙" },
				{ "sh", desc = "Go left window", icon = "" },
				{ "sj", desc = "Go down window", icon = "" },
				{ "sk", desc = "Go up window", icon = "" },
				{ "sl", desc = "Go right window", icon = "" },
			},
		},
	},
}
