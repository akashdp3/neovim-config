require("mini.pairs").setup()

require("mini.surround").setup({
  mappings = {
    highlight = "sH",
  },
})

local statusline = require("mini.statusline")
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

local function lsp_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end

  local names = {}
  for _, client in ipairs(clients) do
    names[#names + 1] = client.name
  end

  return table.concat(names, ", ")
end

local function lsp_progress()
  local progress = vim.lsp.status()
  if progress == "" then
    return ""
  end

  local frame = spinner_frames[(math.floor(vim.uv.hrtime() / 1e8) % #spinner_frames) + 1]
  return frame
end

local function location()
  return "%2l:%-2v"
end

local function progress()
  return "%p%%"
end

local function git_branch()
  local branch = vim.b.gitsigns_head

  if not branch or branch == "" then
    local dir = vim.fn.expand("%:p:h")
    if dir == "" then
      dir = vim.uv.cwd()
    end

    local result = vim.system({ "git", "-C", dir, "branch", "--show-current" }, { text = true }):wait()
    if result.code == 0 and result.stdout then
      branch = result.stdout:gsub("%s+$", "")
    end
  end

  if not branch or branch == "" then
    return ""
  end

  return " " .. branch
end

local function diagnostics_groups()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

  return vim.tbl_filter(function(group)
    return group.strings[1] ~= ""
  end, {
    { hl = "DiagnosticError", strings = { errors > 0 and "●" or "" } },
    { hl = "DiagnosticWarn", strings = { warns > 0 and "●" or "" } },
  })
end

local function macro_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end

  return "@" .. reg
end

local function search_count()
  if vim.v.hlsearch == 0 then
    return ""
  end

  local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
  if result.total == 0 then
    return ""
  end

  return string.format("%d/%d", result.current, result.total)
end

local function encoding()
  local enc = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  return enc ~= "" and enc or ""
end

local function fileformat()
  return vim.bo.fileformat or ""
end

local function filetype()
  return vim.bo.filetype ~= "" and vim.bo.filetype or ""
end

statusline.setup({
  use_icons = vim.g.have_nerd_font == true,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git = git_branch()
      local filename = statusline.section_filename({ trunc_width = 140 })
      local macro = macro_recording()
      local search = search_count()
      local lsp_prog = lsp_progress()
      local lsp = lsp_status()
      local groups = {
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineBranch", strings = { git } },
      }

      vim.list_extend(groups, diagnostics_groups())
      vim.list_extend(groups, {
        "%<",
        { hl = "MiniStatuslineFilename", strings = { filename } },
        { hl = "MiniStatuslineDevinfo", strings = { macro, search } },
        "%=",
        { hl = "MiniStatuslineLspSpinner", strings = { lsp_prog } },
        { hl = "MiniStatuslineLspName", strings = { lsp } },
        { hl = "MiniStatuslineFileinfo", strings = { encoding(), fileformat(), filetype(), progress() } },
        { hl = mode_hl, strings = { location() } },
      })

      return statusline.combine_groups(groups)
    end,
    inactive = function()
      local filename = statusline.section_filename({ trunc_width = 140 })

      return statusline.combine_groups({
        { hl = "MiniStatuslineInactive", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineInactive", strings = { location() } },
      })
    end,
  },
})

local statusline_refresh = vim.api.nvim_create_augroup("MiniStatuslineRefresh", { clear = true })

vim.api.nvim_create_autocmd({
  "BufEnter",
  "CursorHold",
  "DiagnosticChanged",
  "LspAttach",
  "LspDetach",
  "LspProgress",
  "ModeChanged",
  "RecordingEnter",
  "RecordingLeave",
  "WinEnter",
}, {
  group = statusline_refresh,
  callback = function()
    vim.cmd.redrawstatus()
  end,
})

vim.api.nvim_set_hl(0, "MiniStatuslineBranch", { fg = "#e0def4", bg = "#403d52", bold = false })
vim.api.nvim_set_hl(0, "MiniStatuslineLspSpinner", { fg = "#f6c177", bg = "#403d52", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineLspName", { fg = "#9ccfd8", bg = "#403d52", bold = false })
