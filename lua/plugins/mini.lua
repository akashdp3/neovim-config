require("mini.pairs").setup()

require("mini.surround").setup({
  mappings = {
    highlight = "sH",
  },
})

local statusline = require("mini.statusline")
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

-- Cache git branch to avoid spawning a process every redraw
local _branch_cache = ""
local function update_branch_cache()
  local branch = vim.b.gitsigns_head
  if branch and branch ~= "" then
    _branch_cache = " " .. branch
    return
  end
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then dir = vim.uv.cwd() end
  vim.system({ "git", "-C", dir, "branch", "--show-current" }, { text = true }, function(result)
    if result.code == 0 and result.stdout then
      local b = result.stdout:gsub("%s+$", "")
      _branch_cache = b ~= "" and (" " .. b) or ""
    else
      _branch_cache = ""
    end
  end)
end

local function git_branch()
  return _branch_cache
end

local function lsp_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return "" end
  local names = {}
  for _, client in ipairs(clients) do
    names[#names + 1] = client.name
  end
  return table.concat(names, ", ")
end

local function lsp_progress()
  local progress = vim.lsp.status()
  if not progress or progress == "" then return "" end
  local frame = spinner_frames[(math.floor(vim.uv.hrtime() / 1e8) % #spinner_frames) + 1]
  return frame .. " " .. progress
end

local function location()
  return "%2l:%-2v"
end

local function progress()
  return "%p%%"
end

local function diagnostics_groups()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warns  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  return vim.tbl_filter(function(g) return g.strings[1] ~= "" end, {
    { hl = "DiagnosticError", strings = { errors > 0 and "\u{f05e} " .. errors or "" } },
    { hl = "DiagnosticWarn",  strings = { warns  > 0 and "\u{f071} " .. warns  or "" } },
    { hl = "DiagnosticHint",  strings = { hints  > 0 and "\u{f05a} " .. hints  or "" } },
  })
end

local function macro_recording()
  local reg = vim.fn.reg_recording()
  return reg ~= "" and ("\u{f044b} @" .. reg) or ""
end

local function search_count()
  if vim.v.hlsearch == 0 then return "" end
  local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
  if not ok or result.total == 0 then return "" end
  return string.format("\u{e754} %d/%d", result.current, result.total)
end

local function filetype()
  return vim.bo.filetype ~= "" and vim.bo.filetype or ""
end

statusline.setup({
  use_icons = true,
  set_vim_settings = false,
  content = {
    active = function()
      local win_width = vim.api.nvim_win_get_width(0)
      local is_narrow = win_width < 80

      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local filename = statusline.section_filename({ trunc_width = 140 })
      local macro = macro_recording()
      local search = search_count()
      local lsp_prog = lsp_progress()
      local lsp = is_narrow and "" or lsp_status()

      local groups = {
        { hl = mode_hl,                strings = { mode } },
        { hl = "MiniStatuslineBranch", strings = { git_branch() } },
      }

      vim.list_extend(groups, diagnostics_groups())
      vim.list_extend(groups, {
        "%<",
        { hl = "MiniStatuslineFilename", strings = { filename } },
        { hl = "MiniStatuslineDevinfo",  strings = { macro, search } },
        "%=",
        { hl = "MiniStatuslineLspSpinner", strings = { lsp_prog } },
        { hl = "MiniStatuslineLspName",    strings = { lsp } },
        { hl = "MiniStatuslineFileinfo",   strings = { is_narrow and "" or filetype(), progress() } },
        { hl = mode_hl,                    strings = { location() } },
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

-- Update branch cache on buf/dir change (async, not every redraw)
vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "User" }, {
  group = statusline_refresh,
  pattern = { "*", "*", "GitSignsUpdate" },
  callback = update_branch_cache,
})

local palette = require("rose-pine.palette")

vim.api.nvim_set_hl(0, "MiniStatuslineBranch", {
  fg = palette.text,
  bg = palette.surface,
  bold = false,
})

vim.api.nvim_set_hl(0, "MiniStatuslineLspSpinner", {
  fg = palette.love,
  bg = palette.overlay,
  bold = true,
})

vim.api.nvim_set_hl(0, "MiniStatuslineLspName", {
  fg = palette.love,
  bg = palette.overlay,
  bold = false,
})
