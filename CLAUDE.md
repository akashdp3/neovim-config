# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using **Neovim 0.12's native `vim.pack`** plugin manager (no lazy.nvim or packer). All plugins are declared in `lua/plugins/init.lua` via `vim.pack.add({...})` and loaded eagerly on startup.

## Architecture

```
init.lua                   # Entry point: loads config then plugins
lua/
  config/
    init.lua               # Sets mapleader/maplocalleader, requires the rest
    options.lua            # vim.opt settings
    mappings.lua           # All keymaps (general, LSP-independent)
    commands.lua           # User commands (:Format, :FormatToggle, :LspRestartAll, etc.)
  plugins/
    init.lua               # vim.pack.add() declarations + require() for each plugin module
    lsp.lua                # LSP server configs, LspAttach keymaps, diagnostic config
    conform.lua            # Formatter config (format-on-save)
    blink.lua              # Completion (blink.cmp)
    telescope.lua          # Fuzzy finder + file browser keymaps
    treesitter.lua         # Syntax / parser config
    colorscheme.lua        # rose-pine theme
    gitsigns.lua           # Git decorations
    mini.lua               # mini.nvim modules
    which-key.lua          # Key hint popup
    obsidian.lua           # Obsidian.nvim for note-taking
    diagnostics-ui.lua     # tiny-inline-diagnostic
```

## Key conventions

- **Adding a plugin**: add a `{ src = gh("owner/repo") }` entry in `lua/plugins/init.lua`, then `require("plugins.mymodule")` at the bottom of that file, and create `lua/plugins/mymodule.lua`.
- **Keymap helper**: `mappings.lua` uses a local `o(desc, extra)` helper that merges `noremap = true, silent = true` with a description. LSP keymaps use a similar `lo(desc)` helper scoped to the attached buffer inside the `LspAttach` autocmd.
- **LSP**: servers are declared in the `servers` table in `lua/plugins/lsp.lua`. Mason auto-installs them (`ensure_installed`). Each server entry passes `blink.cmp` capabilities. Enable/disable via `vim.lsp.enable()` at the bottom of that file.
- **Formatting**: conform.nvim formats on save unless `vim.g.disable_autoformat` or `vim.b.disable_autoformat` is set. Toggle per-buffer with `<leader>tf` / `:FormatToggle`; globally with `:FormatToggleGlobal`.
- **Folding**: defaults to `foldmethod=indent`; switches to LSP expr folding (`vim.lsp.foldexpr()`) on `LspAttach` when the server supports `textDocument/foldingRange`.

## Reloading / testing changes

- `<leader><leader>x` — source the current file (`:luafile %`)
- `<leader>x` — execute current line as Lua
- `<leader><leader>r` — restart Neovim (`:restart`)
- `:LspRestartAll` — stop all LSP clients and re-open the buffer

## LSP servers managed by Mason

`lua_ls`, `jsonls`, `cssls`, `html`, `ts_ls`, `astro`, `rust_analyzer`, `gopls`

## Formatters (conform.nvim)

- Lua → `stylua`
- JS/TS/JSON/HTML/CSS/Astro/Markdown → `prettierd` (fallback: `prettier`)
- Go → `gofmt`
- Rust → `rustfmt`
