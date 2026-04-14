require("blink.cmp").setup({
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "v1.10.2",
		},
	},
	keymap = {
		preset = "enter",
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 150,
		},
		ghost_text = {
			enabled = true,
		},
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},
	},
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	signature = {
		enabled = true,
	},
})
