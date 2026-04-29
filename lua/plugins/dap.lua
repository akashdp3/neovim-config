local map = vim.keymap.set
local s = { noremap = true, silent = true }
local function o(desc)
	return vim.tbl_extend("force", s, { desc = desc })
end

-- ── Mason-DAP: auto-install adapters ─────────────────────────────────────────
pcall(function()
	require("mason-nvim-dap").setup({
		ensure_installed = { "js", "chrome", "delve", "codelldb" },
		automatic_installation = true,
		handlers = {},
	})
end)

local ok_dap, dap = pcall(require, "nvim-dap")
if not ok_dap then
	return
end

-- ── Lua adapter (osv — optional) ─────────────────────────────────────────────
local ok_osv, osv = pcall(require, "osv")
if ok_osv then
	dap.adapters.nlua = function(callback, config)
		callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
	end
	dap.configurations.lua = {
		{
			type = "nlua",
			request = "attach",
			name = "Attach to running Neovim instance",
			host = "127.0.0.1",
			port = 8086,
		},
	}
	map("n", "<leader>dl", osv.launch, o("DAP: Launch Lua server (osv)"))
end

-- ── UI ────────────────────────────────────────────────────────────────────────
local ok_ui, dapui = pcall(require, "dapui")
if ok_ui then
	dapui.setup({
		icons = { expanded = "", collapsed = "", current_frame = "" },
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.30 },
					{ id = "breakpoints", size = 0.20 },
					{ id = "stacks", size = 0.30 },
					{ id = "watches", size = 0.20 },
				},
				size = 40,
				position = "left",
			},
			{
				elements = {
					{ id = "repl", size = 0.50 },
					{ id = "console", size = 0.50 },
				},
				size = 12,
				position = "bottom",
			},
		},
		floating = { border = "rounded", mappings = { close = { "q", "<Esc>" } } },
		windows = { indent = 1 },
		render = { max_type_length = nil, max_value_lines = 100 },
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

-- ── Signs ─────────────────────────────────────────────────────────────────────
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn", linehl = "DapStoppedLine", numhl = "" })

-- ── Virtual text ──────────────────────────────────────────────────────────────
require("dap.ext.virt_text").setup({ commented = true })

-- ── Keymaps ───────────────────────────────────────────────────────────────────
map("n", "<leader>dc", dap.continue, o("DAP: Continue / Start"))
map("n", "<leader>dq", dap.terminate, o("DAP: Terminate"))
map("n", "<leader>dr", dap.restart, o("DAP: Restart"))
map("n", "<leader>dp", dap.pause, o("DAP: Pause"))

map("n", "<leader>do", dap.step_over, o("DAP: Step over"))
map("n", "<leader>di", dap.step_into, o("DAP: Step into"))
map("n", "<leader>dO", dap.step_out, o("DAP: Step out"))
map("n", "<leader>dR", dap.run_to_cursor, o("DAP: Run to cursor"))

map("n", "<leader>dt", dap.toggle_breakpoint, o("DAP: Toggle breakpoint"))
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, o("DAP: Conditional breakpoint"))
map("n", "<leader>dL", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, o("DAP: Log point"))
map("n", "<leader>dX", dap.clear_breakpoints, o("DAP: Clear all breakpoints"))
map("n", "<leader>de", function()
	dap.list_breakpoints()
	vim.cmd("copen")
end, o("DAP: Breakpoints (qflist)"))

map("n", "<leader>d_", dap.run_last, o("DAP: Re-run last"))
map({ "n", "v" }, "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, o("DAP: Hover value"))
map({ "n", "v" }, "<leader>dP", function()
	require("dap.ui.widgets").preview()
end, o("DAP: Preview value"))
map("n", "<leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end, o("DAP: Frames (float)"))
map("n", "<leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, o("DAP: Scopes (float)"))

if ok_ui then
	map("n", "<leader>du", dapui.toggle, o("DAP: Toggle UI"))
	map("n", "<leader>dC", dapui.close, o("DAP: Close UI"))
end
