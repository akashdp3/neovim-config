local map = vim.keymap.set
local s = { noremap = true, silent = true }

local ok_blink, blink = pcall(require, "blink.cmp")
local capabilities = ok_blink and blink.get_lsp_capabilities() or nil

local servers = {
	lua_ls = {
		capabilities = capabilities,
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = { vim.env.VIMRUNTIME .. "/lua" },
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	jsonls = { capabilities = capabilities },
	cssls = { capabilities = capabilities },
	html = { capabilities = capabilities },
	ts_ls = { capabilities = capabilities },
	astro = { capabilities = capabilities },
	rust_analyzer = { capabilities = capabilities },
	gopls = { capabilities = capabilities },
}

pcall(function()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_enable = false,
	})
end)

for name, config in pairs(servers) do
	vim.lsp.config(name, config)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspFeatures", {}),
	callback = function(ev)
		local opts_buf = { buffer = ev.buf }
		local function lo(desc)
			return vim.tbl_extend("force", s, opts_buf, { desc = desc })
		end

		-- Navigation
		map("n", "K", function()
			vim.lsp.buf.hover({ max_width = 80, max_height = 20 })
		end, lo("Hover documentation"))
		map("n", "gd", vim.lsp.buf.definition, lo("Go to definition"))
		map("n", "gD", vim.lsp.buf.declaration, lo("Go to declaration"))
		map("n", "gi", vim.lsp.buf.implementation, lo("Go to implementation"))
		map("n", "go", vim.lsp.buf.type_definition, lo("Go to type definition"))
		map("n", "gr", vim.lsp.buf.references, lo("Go to references"))
		map("n", "gK", function()
			vim.lsp.buf.signature_help({ max_width = 80, max_height = 20 })
		end, lo("Signature help"))
		map("i", "<C-k>", function()
			vim.lsp.buf.signature_help({ max_width = 80, max_height = 20 })
		end, lo("Signature help"))

		-- Actions
		map("n", "<F2>", vim.lsp.buf.rename, lo("Rename symbol"))
		map({ "n", "x" }, "<F3>", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, lo("Format code"))
		map({ "n", "v" }, "<F4>", vim.lsp.buf.code_action, lo("Code action"))

		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lo("Code action"))
		map("n", "<leader>cr", vim.lsp.buf.rename, lo("Rename symbol"))
		map({ "n", "x" }, "<leader>cf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, lo("Format code"))

		-- LSP lists
		map("n", "<leader>cs", vim.lsp.buf.document_symbol, lo("Document symbols"))
		map("n", "<leader>cS", vim.lsp.buf.workspace_symbol, lo("Workspace symbols"))

		-- Toggle inlay hints
		map("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
		end, lo("Toggle inlay hints"))

		-- Toggle codelens
		map("n", "<leader>cl", function()
			local enabled = vim.lsp.codelens.is_enabled({ bufnr = ev.buf })
			vim.lsp.codelens.enable(not enabled, { bufnr = ev.buf })
		end, lo("Toggle codelens"))

		map("n", "<leader>tf", "<cmd>FormatToggle<CR>", lo("Toggle autoformat"))

		local client = vim.lsp.get_clients({ id = ev.data.client_id })[1]
		if not client then
			return
		end

		if client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win].foldmethod = "expr"
			vim.wo[win].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		format = function(diagnostic)
			local msg = diagnostic.message:gsub("\n", " ")
			if #msg > 60 then
				msg = msg:sub(1, 57) .. "..."
			end
			return msg
		end,
		severity = { min = vim.diagnostic.severity.HINT },
	},
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "\u{f05e} ",
			[vim.diagnostic.severity.WARN] = "\u{f071} ",
			[vim.diagnostic.severity.HINT] = "\u{f05a} ",
			[vim.diagnostic.severity.INFO] = "\u{f05a} ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
	update_in_insert = false,
	underline = {
		severity = { min = vim.diagnostic.severity.HINT },
	},
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		source = true,
		header = " Diagnostics",
		prefix = function(diagnostic)
			local icons = {
				[vim.diagnostic.severity.ERROR] = "\u{f05e} ",
				[vim.diagnostic.severity.WARN] = "\u{f071} ",
				[vim.diagnostic.severity.HINT] = "\u{f05a} ",
				[vim.diagnostic.severity.INFO] = "\u{f05a} ",
			}
			return icons[diagnostic.severity] or "● ",
				"DiagnosticSign" .. ({ "Error", "Warn", "Hint", "Info" })[diagnostic.severity]
		end,
		suffix = function(diagnostic)
			return diagnostic.code and string.format(" [%s]", diagnostic.code) or "", "Comment"
		end,
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float({
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			source = true,
			prefix = " ",
			scope = "cursor",
		})
	end,
})

vim.lsp.enable(vim.tbl_keys(servers))
