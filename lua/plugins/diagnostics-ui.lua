local ok, tiny_inline_diagnostic = pcall(require, "tiny-inline-diagnostic")
if not ok then
  return
end

tiny_inline_diagnostic.setup({
  preset = "modern",
  options = {
    show_source = true,
    use_icons_from_diagnostic = true,
    multilines = {
      enabled = true,
      always_show = true,
    },
    show_all_diags_on_cursorline = true,
    enable_on_insert = false,
    overflow = {
      mode = "wrap",
    },
    break_line = {
      enabled = true,
      after = 80,
    },
    virt_texts = {
      priority = 2048,
    },
  },
  signs = {
    left = "",
    right = "",
    diag = "●",
    arrow = "    ",
    up_arrow = "    ",
    vertical = " │",
    vertical_end = " └",
  },
  blend = {
    factor = 0.22,
  },
})
