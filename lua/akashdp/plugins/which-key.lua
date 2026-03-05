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
			delay = 200,
			icons = {
				breadcrumb = "»",
				separator = "→",
				group = "+",
				mappings = true,
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
				-- Top-level groups
				{ "<leader>f", group = "Find/Files", icon = "󰈞" },
				{ "<leader>e", group = "Explorer", icon = "󰙅" },
				{ "<leader>t", group = "Terminal/Tmux", icon = "" },
				{ "<leader>w", group = "Window", icon = "󰖯" },
				{ "<leader>b", group = "Buffer", icon = "󰓩" },
				{ "<leader>y", group = "Yank/Copy", icon = "" },
				{ "<leader>c", group = "Code", icon = "" },
				{ "<leader>s", group = "Search/Noice", icon = "󰛔" },
				{ "<leader>x", group = "Diagnostics", icon = "󱍼" },
				{ "<leader>h", group = "Harpoon", icon = "󱡀" },
				{ "<leader>a", group = "AI/Claude", icon = "󰚩" },
				{ "<leader>i", group = "Info/Inspect", icon = "" },
				{ "<leader>l", group = "Lazy", icon = "󰒲" },

				-- Find/Files
				{ "<leader>ff", desc = "Find files", icon = "󰈞" },
				{ "<leader>fg", desc = "Live grep", icon = "󰊄" },
				{ "<leader>fb", desc = "Find buffers", icon = "󰓩" },
				{ "<leader>fh", desc = "Help tags", icon = "󰋖" },
				{ "<leader>fr", desc = "Recent files", icon = "󰋚" },
				{ "<leader>fd", desc = "File browser", icon = "󰙅" },
				{ "<leader>fs", desc = "Save file", icon = "󰆓" },

				-- Explorer
				{ "<leader>ef", desc = "Open Netrw", icon = "󰙅" },

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

				-- Code (LSP + Trouble)
				{ "<leader>ca", desc = "Code action", icon = "󰌵" },
				{ "<leader>cr", desc = "Rename symbol", icon = "󰏫" },
				{ "<leader>cf", desc = "Format code", icon = "󰉢" },
				{ "<leader>cs", desc = "Symbols (Trouble)", icon = "󰅪" },
				{ "<leader>cS", desc = "LSP refs/defs (Trouble)", icon = "󰁨" },

				-- AI/Claude
				{ "<leader>ac", desc = "Toggle Claude", icon = "󰚩" },
				{ "<leader>af", desc = "Focus Claude", icon = "󰆤" },
				{ "<leader>ar", desc = "Resume Claude", icon = "󰑓" },
				{ "<leader>aC", desc = "Continue Claude", icon = "󰒭" },
				{ "<leader>am", desc = "Select model", icon = "󰛓" },
				{ "<leader>ab", desc = "Add current buffer", icon = "󰈙" },
				{ "<leader>as", desc = "Send to Claude", icon = "󰑩", mode = "v" },
				{ "<leader>aa", desc = "Accept diff", icon = "󰄬" },
				{ "<leader>ad", desc = "Deny diff", icon = "󰅖" },

				-- Diagnostics/Quickfix
				{ "<leader>xd", desc = "Show diagnostic float", icon = "󰙨" },
				{ "<leader>xx", desc = "Diagnostics (Trouble)", icon = "󱍼" },
				{ "<leader>xX", desc = "Buffer diagnostics (Trouble)", icon = "󰈙" },
				{ "<leader>xb", desc = "Buffer diagnostics (Telescope)", icon = "󰈞" },
				{ "<leader>xL", desc = "Location list (Trouble)", icon = "󰆤" },
				{ "<leader>xQ", desc = "Quickfix list (Trouble)", icon = "󰁨" },
				{ "<leader>xq", desc = "Quickfix (Telescope)", icon = "󰈞" },
				{ "<leader>xl", desc = "Location list (Telescope)", icon = "󰈞" },
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
				{ "<leader>sn", group = "Noice", icon = "󰎟" },
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
				{ "<leader>lg", desc = "LazyGit", icon = "" },

				-- Source/Execute
				{ "<leader><leader>x", desc = "Source current file", icon = "󰑓" },
				{ "<leader>x", desc = "Execute line as Lua", icon = "" },

				-- Yank
				{ "yc", desc = "Yank line to clipboard", icon = "" },
				{ "<leader>yc", desc = "Yank selection to clipboard", icon = "", mode = "v" },

				-- Goto group
				{ "g", group = "Goto", icon = "" },
				{ "gd", desc = "Go to definition", icon = "󰈮" },
				{ "gD", desc = "Glance definitions", icon = "󰍉" },
				{ "gi", desc = "Go to implementation", icon = "󰡱" },
				{ "gr", desc = "Go to references", icon = "󰈇" },
				{ "gR", desc = "Glance references", icon = "󰍉" },
				{ "gY", desc = "Glance type defs", icon = "󰍉" },
				{ "gM", desc = "Glance implementations", icon = "󰍉" },
				{ "go", desc = "Go to type definition", icon = "󰊄" },
				{ "gK", desc = "Signature help", icon = "󰏪" },

				-- Surround (mini.surround) - gs prefix
				{ "gs", group = "Surround", icon = "󰅪" },
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
				{ "z", group = "Fold", icon = "󰘖" },
				{ "za", desc = "Toggle fold", icon = "󰘖" },
				{ "zA", desc = "Toggle all folds", icon = "󰘖" },
				{ "zc", desc = "Close fold", icon = "󰁂" },
				{ "zC", desc = "Close all folds", icon = "󰁂" },
				{ "zo", desc = "Open fold", icon = "󰁃" },
				{ "zO", desc = "Open all folds", icon = "󰁃" },
				{ "zM", desc = "Close all", icon = "󰁂" },
				{ "zR", desc = "Open all", icon = "󰁃" },

				-- Next/Prev navigation
				{ "]", group = "Next", icon = "󰒭" },
				{ "]d", desc = "Next diagnostic", icon = "󱍼" },
				{ "]e", desc = "Next error", icon = "" },
				{ "]w", desc = "Next warning", icon = "" },
				{ "]h", desc = "Next hunk", icon = "" },

				{ "[", group = "Previous", icon = "󰒮" },
				{ "[d", desc = "Previous diagnostic", icon = "󱍼" },
				{ "[e", desc = "Previous error", icon = "" },
				{ "[w", desc = "Previous warning", icon = "" },
				{ "[h", desc = "Previous hunk", icon = "" },

				-- Buffer navigation (number keys)
				{ "<leader>1", desc = "Buffer 1", icon = "󰎤" },
				{ "<leader>2", desc = "Buffer 2", icon = "󰎧" },
				{ "<leader>3", desc = "Buffer 3", icon = "󰎪" },
				{ "<leader>4", desc = "Buffer 4", icon = "󰎭" },
				{ "<leader>5", desc = "Buffer 5", icon = "󰎱" },

				-- LSP (shown after LspAttach)
				{ "K", desc = "Hover documentation", icon = "󰋖" },
				{ "<F2>", desc = "Rename symbol", icon = "󰏫" },
				{ "<F3>", desc = "Format code", icon = "󰉢" },
				{ "<F4>", desc = "Code action", icon = "󰌵" },

				-- Window splits/navigation
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
