local ok, telescope = pcall(require, "telescope")

if not ok then
  return
end

telescope.setup({
  defaults = {
    border = true,
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        width = 0.72,
        height = 0.64,
        preview_width = 0.52,
      },
      vertical = {
        prompt_position = "top",
        width = 0.72,
        height = 0.7,
      },
    },
    results_title = false,
    prompt_title = false,
    preview_title = false,
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      grouped = true,
      previewer = true,
      initial_mode = "normal",
    },
  },
})

pcall(telescope.load_extension, "file_browser")

local builtin = require("telescope.builtin")
local extensions = telescope.extensions

local function open_file_browser()
  local path = vim.fn.expand("%:p:h")

  if path == "" then
    path = vim.loop.cwd()
  end

  extensions.file_browser.file_browser({
    path = path,
    select_buffer = true,
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
  })
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fd", open_file_browser, { desc = "File browser" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
