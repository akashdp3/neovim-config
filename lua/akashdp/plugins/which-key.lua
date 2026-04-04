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
				padding = { 1, 2 },
				title = true,
				title_pos = "center",
			},
			layout = {
				width = { min = 20, max = 50 },
				spacing = 3,
			},
			spec = {
				-- ════════════════════════════════════════════════════════
				-- Leader groups
				-- ════════════════════════════════════════════════════════
				{ "<leader>f", group = "Find/Files", icon = "󰈞" },
				{ "<leader>e", group = "Explorer", icon = "󰙅" },
				{ "<leader>g", group = "Git", icon = "" },
				{ "<leader>t", group = "Terminal/Tmux", icon = "" },
				{ "<leader>w", group = "Window", icon = "󰖯" },
				{ "<leader>b", group = "Buffer", icon = "󰓩" },
				{ "<leader>c", group = "Code (LSP)", icon = "" },
				{ "<leader>s", group = "Search/Noice", icon = "󰛔" },
				{ "<leader>x", group = "Diagnostics/Quickfix", icon = "󱍼" },
				{ "<leader>h", group = "Harpoon", icon = "󱡀" },
				{ "<leader>a", group = "AI/Claude", icon = "󰚩" },
				{ "<leader>n", group = "Notes/Obsidian", icon = "󰠮" },
				{ "<leader>i", group = "Info/Inspect", icon = "" },
				{ "<leader>l", group = "Lazy", icon = "󰒲" },
				{ "<leader><leader>", group = "Source/Restart", icon = "󰑓" },

				-- ════════════════════════════════════════════════════════
				-- Find/Files  <leader>f
				-- Telescope pickers and file operations
				-- ════════════════════════════════════════════════════════
				{ "<leader>ff", desc = "Find files", icon = "󰈞" },
				{ "<leader>fg", desc = "Live grep", icon = "󰊄" },
				{ "<leader>fb", desc = "Find buffers", icon = "󰓩" },
				{ "<leader>fh", desc = "Help tags", icon = "󰋖" },
				{ "<leader>fr", desc = "Recent files", icon = "󰋚" },
				{ "<leader>fd", desc = "File browser (current dir)", icon = "󰙅" },
				{ "<leader>fs", desc = "Save file (++p auto-mkdir)", icon = "󰆓" },

				-- ════════════════════════════════════════════════════════
				-- Explorer  <leader>e
				-- ════════════════════════════════════════════════════════
				{ "<leader>ef", desc = "Open Netrw", icon = "󰙅" },

				-- ════════════════════════════════════════════════════════
				-- Git  <leader>g
				-- Gitsigns hunk operations and blame
				-- ════════════════════════════════════════════════════════
				{ "<leader>gs", desc = "Stage hunk", icon = "󰐕" },
				{ "<leader>gr", desc = "Reset hunk", icon = "󰜺" },
				{ "<leader>gs", desc = "Stage hunk (visual)", icon = "󰐕", mode = "v" },
				{ "<leader>gr", desc = "Reset hunk (visual)", icon = "󰜺", mode = "v" },
				{ "<leader>gS", desc = "Stage entire buffer", icon = "󰄬" },
				{ "<leader>gu", desc = "Undo stage hunk", icon = "󰕌" },
				{ "<leader>gR", desc = "Reset entire buffer", icon = "󰅖" },
				{ "<leader>gp", desc = "Preview hunk inline", icon = "󰈈" },
				{ "<leader>gb", desc = "Blame line (full)", icon = "" },
				{ "<leader>gB", desc = "Toggle line blame", icon = "" },
				{ "<leader>gd", desc = "Diff this buffer", icon = "" },

				-- ════════════════════════════════════════════════════════
				-- Terminal/Tmux  <leader>t
				-- Tmux integration via Telescope + terminal mode
				-- ════════════════════════════════════════════════════════
				{ "<leader>tp", desc = "Switch tmux panes", icon = "󰓫" },
				{ "<leader>ts", desc = "Switch tmux sessions", icon = "󱂬" },
				{ "<leader>tw", desc = "Switch tmux windows", icon = "󰖯" },
				{ "<leader>tn", desc = "Terminal normal mode", icon = "" },

				-- ════════════════════════════════════════════════════════
				-- Window  <leader>w
				-- Split management and resizing
				-- ════════════════════════════════════════════════════════
				{ "<leader>wm", desc = "Maximize (close others)", icon = "󰁌" },
				{ "<leader>we", desc = "Equalize sizes", icon = "󰕭" },

				-- ════════════════════════════════════════════════════════
				-- Buffer  <leader>b
				-- Buffer deletion via mini.bufremove
				-- ════════════════════════════════════════════════════════
				{ "<leader>bd", desc = "Delete buffer", icon = "󰅖" },
				{ "<leader>bD", desc = "Delete buffer (force)", icon = "󰅗" },

				-- ════════════════════════════════════════════════════════
				-- Code (LSP)  <leader>c
				-- Code actions, rename, format, symbols
				-- ════════════════════════════════════════════════════════
				{ "<leader>ca", desc = "Code action", icon = "󰌵" },
				{ "<leader>cr", desc = "Rename symbol", icon = "󰏫" },
				{ "<leader>cf", desc = "Format code (async)", icon = "󰉢" },
				{ "<leader>cs", desc = "Document symbols", icon = "󰅪" },
				{ "<leader>cS", desc = "Workspace symbols", icon = "󰁨" },

				-- ════════════════════════════════════════════════════════
				-- AI/Claude  <leader>a
				-- ════════════════════════════════════════════════════════
				{ "<leader>ac", desc = "Toggle Claude", icon = "󰚩" },
				{ "<leader>af", desc = "Focus Claude", icon = "󰆤" },
				{ "<leader>ar", desc = "Resume Claude", icon = "󰑓" },
				{ "<leader>aC", desc = "Continue Claude", icon = "󰒭" },
				{ "<leader>am", desc = "Select model", icon = "󰛓" },
				{ "<leader>ab", desc = "Add current buffer", icon = "󰈙" },
				{ "<leader>as", desc = "Send to Claude", icon = "󰑩", mode = "v" },
				{ "<leader>aa", desc = "Accept diff", icon = "󰄬" },
				{ "<leader>ad", desc = "Deny diff", icon = "󰅖" },

				-- ════════════════════════════════════════════════════════
				-- Diagnostics/Quickfix  <leader>x
				-- Native diagnostics + Telescope diagnostic pickers
				-- ════════════════════════════════════════════════════════
				{ "<leader>xd", desc = "Diagnostic float at cursor", icon = "󰙨" },
				{ "<leader>xx", desc = "All diagnostics → quickfix", icon = "󱍼" },
				{ "<leader>xX", desc = "Buffer diagnostics → loclist", icon = "󰈙" },
				{ "<leader>xb", desc = "Buffer diagnostics (Telescope)", icon = "󰈞" },
				{ "<leader>xw", desc = "Workspace diagnostics (Telescope)", icon = "󰒋" },
				{ "<leader>xq", desc = "Quickfix list (Telescope)", icon = "󰈞" },
				{ "<leader>xl", desc = "Location list (Telescope)", icon = "󰈞" },
				{ "<leader>xL", desc = "Open location list", icon = "󰆤" },
				{ "<leader>xQ", desc = "Open quickfix list", icon = "󰁨" },

				-- ════════════════════════════════════════════════════════
				-- Harpoon  <leader>h
				-- Quick file bookmarks (harpoon2)
				-- ════════════════════════════════════════════════════════
				{ "<leader>ha", desc = "Add file to harpoon", icon = "󰐕" },
				{ "<leader>hh", desc = "Toggle quick menu", icon = "󱡀" },
				{ "<leader>h1", desc = "Jump to file 1", icon = "󰎤" },
				{ "<leader>h2", desc = "Jump to file 2", icon = "󰎧" },
				{ "<leader>h3", desc = "Jump to file 3", icon = "󰎪" },
				{ "<leader>h4", desc = "Jump to file 4", icon = "󰎭" },
				{ "<leader>hn", desc = "Next harpoon file", icon = "󰒭" },
				{ "<leader>hp", desc = "Previous harpoon file", icon = "󰒮" },

				-- ════════════════════════════════════════════════════════
				-- Notes/Obsidian  <leader>n
				-- Obsidian vault operations (markdown ft only)
				-- ════════════════════════════════════════════════════════
				{ "<leader>nn", desc = "New note", icon = "󰎠" },
				{ "<leader>no", desc = "Quick switch", icon = "󰈞" },
				{ "<leader>ns", desc = "Search notes", icon = "󰊄" },
				{ "<leader>nt", desc = "Today's journal", icon = "󰃮" },
				{ "<leader>ny", desc = "Yesterday's journal", icon = "󰃮" },
				{ "<leader>nm", desc = "Tomorrow's journal", icon = "󰃮" },
				{ "<leader>nb", desc = "Backlinks", icon = "󰌹" },
				{ "<leader>nl", desc = "Links", icon = "󰌹" },
				{ "<leader>ni", desc = "Insert template", icon = "󰘙" },
				{ "<leader>nf", desc = "Follow link", icon = "󰌹" },
				{ "<leader>nr", desc = "Rename note", icon = "󰏫" },
				{ "<leader>nT", desc = "Browse tags", icon = "󰓹" },

				-- ════════════════════════════════════════════════════════
				-- Search/Noice  <leader>s
				-- Noice message management
				-- ════════════════════════════════════════════════════════
				{ "<leader>sn", group = "Noice", icon = "󰎟" },
				{ "<leader>snl", desc = "Last message", icon = "󰋚" },
				{ "<leader>snh", desc = "Message history", icon = "󰋖" },
				{ "<leader>sna", desc = "All messages", icon = "󰍡" },
				{ "<leader>snt", desc = "Noice picker", icon = "󰈞" },
				{ "<leader>snd", desc = "Dismiss all", icon = "󰅖" },

				-- ════════════════════════════════════════════════════════
				-- Quick actions (no group prefix)
				-- ════════════════════════════════════════════════════════
				{ "<leader>u", desc = "Toggle Undotree", icon = "󰕌" },
				{ "<leader>o", desc = "Blank line below", icon = "󰁅" },
				{ "<leader>O", desc = "Blank line above", icon = "󰁝" },
				{ "<leader>q", desc = "Quit", icon = "󰈆" },
				{ "<leader>Q", desc = "Force quit all", icon = "󰗼" },
				{ "<leader>ih", desc = "Toggle inlay hints", icon = "󰌵" },
				{ "<leader>lg", desc = "LazyGit", icon = "" },
				{ "<leader>j", desc = "Loclist next", icon = "󰒭" },
				{ "<leader>k", desc = "Loclist prev", icon = "󰒮" },

				-- ════════════════════════════════════════════════════════
				-- Source/Restart  <leader><leader>
				-- Config development workflow
				-- ════════════════════════════════════════════════════════
				{ "<leader><leader>x", desc = "Source current file", icon = "󰑓" },
				{ "<leader><leader>r", desc = "Restart Neovim", icon = "󰜉" },
				{ "<leader>x", desc = "Execute line as Lua", icon = "" },
				{ "<leader>x", desc = "Execute selection as Lua", icon = "", mode = "v" },

				-- ════════════════════════════════════════════════════════
				-- Goto  g
				-- LSP navigation (buffer-local after LspAttach)
				-- ════════════════════════════════════════════════════════
				{ "g", group = "Goto", icon = "" },
				{ "gd", desc = "Definition", icon = "󰈮" },
				{ "gD", desc = "Declaration", icon = "󰈮" },
				{ "gi", desc = "Implementation", icon = "󰡱" },
				{ "go", desc = "Type definition", icon = "󰊄" },
				{ "gr", desc = "References", icon = "󰈇" },
				{ "gK", desc = "Signature help", icon = "󰏪" },
				-- 0.12 default LSP mappings (auto-registered by Neovim)
				{ "gra", desc = "Code action (0.12 default)", icon = "󰌵" },
				{ "gri", desc = "Implementation (0.12 default)", icon = "󰡱" },
				{ "grn", desc = "Rename (0.12 default)", icon = "󰏫" },
				{ "grr", desc = "References (0.12 default)", icon = "󰈇" },
				{ "grt", desc = "Type definition (0.12 default)", icon = "󰊄" },
				{ "grx", desc = "Run codelens", icon = "󰌵" },
				{ "gO", desc = "Document symbols (0.12 default)", icon = "󰅪" },

				-- ════════════════════════════════════════════════════════
				-- Surround  gs
				-- mini.surround operations
				-- ════════════════════════════════════════════════════════
				{ "gs", group = "Surround", icon = "󰅪" },
				{ "gsa", desc = "Add surrounding", icon = "󰐕" },
				{ "gsd", desc = "Delete surrounding", icon = "󰅖" },
				{ "gsr", desc = "Replace surrounding", icon = "󰏫" },
				{ "gsf", desc = "Find surrounding (right)", icon = "󰈞" },
				{ "gsF", desc = "Find surrounding (left)", icon = "󰈞" },
				{ "gsh", desc = "Highlight surrounding", icon = "󰸱" },
				{ "gsn", desc = "Update n_lines", icon = "󰎠" },

				-- ════════════════════════════════════════════════════════
				-- Flash  s/S
				-- Jump and treesitter selection
				-- ════════════════════════════════════════════════════════
				{ "s", desc = "Flash jump", icon = "󰉁" },
				{ "S", desc = "Flash treesitter select", icon = "󰐅" },

				-- ════════════════════════════════════════════════════════
				-- Folds  z
				-- Powered by vim.lsp.foldexpr() (semantic folding)
				-- ════════════════════════════════════════════════════════
				{ "z", group = "Fold (LSP)", icon = "󰘖" },
				{ "za", desc = "Toggle fold at cursor", icon = "󰘖" },
				{ "zA", desc = "Toggle fold recursively", icon = "󰘖" },
				{ "zc", desc = "Close fold at cursor", icon = "󰁂" },
				{ "zC", desc = "Close fold recursively", icon = "󰁂" },
				{ "zo", desc = "Open fold at cursor", icon = "󰁃" },
				{ "zO", desc = "Open fold recursively", icon = "󰁃" },
				{ "zM", desc = "Close all folds", icon = "󰁂" },
				{ "zR", desc = "Open all folds", icon = "󰁃" },

				-- ════════════════════════════════════════════════════════
				-- Next/Prev  ]/[
				-- Diagnostic, error, warning, git hunk navigation
				-- ════════════════════════════════════════════════════════
				{ "]", group = "Next", icon = "󰒭" },
				{ "]d", desc = "Next diagnostic", icon = "󱍼" },
				{ "]e", desc = "Next error", icon = "" },
				{ "]w", desc = "Next warning", icon = "" },
				{ "]h", desc = "Next git hunk", icon = "" },
				{ "]c", desc = "Next git change (diff-aware)", icon = "" },

				{ "[", group = "Previous", icon = "󰒮" },
				{ "[d", desc = "Prev diagnostic", icon = "󱍼" },
				{ "[e", desc = "Prev error", icon = "" },
				{ "[w", desc = "Prev warning", icon = "" },
				{ "[h", desc = "Prev git hunk", icon = "" },
				{ "[c", desc = "Prev git change (diff-aware)", icon = "" },

				-- ════════════════════════════════════════════════════════
				-- Treesitter selection  an/in (visual mode, 0.12 default)
				-- Incremental expand/shrink by syntax node
				-- ════════════════════════════════════════════════════════
				{ "an", desc = "Expand to next node", mode = "v", icon = "󰐅" },
				{ "in", desc = "Shrink to inner node", mode = "v", icon = "󰐅" },
				{ "]n", desc = "Next sibling node", mode = "v", icon = "󰐅" },
				{ "[n", desc = "Prev sibling node", mode = "v", icon = "󰐅" },

				-- ════════════════════════════════════════════════════════
				-- Text objects
				-- ════════════════════════════════════════════════════════
				{ "ih", desc = "Git hunk (text object)", mode = { "o", "x" }, icon = "" },

				-- ════════════════════════════════════════════════════════
				-- LSP (function keys)
				-- Buffer-local after LspAttach
				-- ════════════════════════════════════════════════════════
				{ "K", desc = "Hover documentation", icon = "󰋖" },
				{ "<F2>", desc = "Rename symbol", icon = "󰏫" },
				{ "<F3>", desc = "Format code", icon = "󰉢" },
				{ "<F4>", desc = "Code action", icon = "󰌵" },

				-- ════════════════════════════════════════════════════════
				-- Window splits/navigation  s
				-- ════════════════════════════════════════════════════════
				{ "ss", desc = "Horizontal split", icon = "󰇘" },
				{ "sv", desc = "Vertical split", icon = "󰇙" },
				{ "sh", desc = "Go left window", icon = "" },
				{ "sj", desc = "Go down window", icon = "" },
				{ "sk", desc = "Go up window", icon = "" },
				{ "sl", desc = "Go right window", icon = "" },

				-- ════════════════════════════════════════════════════════
				-- Misc normal mode
				-- ════════════════════════════════════════════════════════
				{ "+", desc = "Increment number", icon = "󰐕" },
				{ "-", desc = "Decrement number", icon = "󰍴" },
				{ "dw", desc = "Delete word backwards", icon = "󰅖" },
				{ "J", desc = "Join lines (keep cursor)", icon = "󰗈" },

				-- ════════════════════════════════════════════════════════
				-- Visual mode
				-- ════════════════════════════════════════════════════════
				{ "J", desc = "Move selection down", mode = "v", icon = "" },
				{ "K", desc = "Move selection up", mode = "v", icon = "" },
				{ "p", desc = "Paste (don't yank replaced)", mode = "x", icon = "" },
			},
		},
	},
}
