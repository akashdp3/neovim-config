local mappings = require("config.mappings")


local servers = {
  "lua_ls",
  "jsonls",
  "cssls",
  "html",
  "ts_ls",
  "astro",
  "rust_analyzer",
  "gopls",
}

pcall(function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = servers,
  })
end)

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspFeatures", {}),
  callback = function(ev)
    mappings.lsp_attach(ev)

    local client = vim.lsp.get_clients({ id = ev.data.client_id })[1]
    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
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
      return icons[diagnostic.severity] or "● ", "DiagnosticSign" .. ({ "Error", "Warn", "Hint", "Info" })[diagnostic.severity]
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

vim.lsp.enable(servers)
