# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a modular fork of kickstart.nvim - a well-documented, minimal Neovim configuration that serves as a starting point rather than a distribution. The configuration is split into multiple files for better organization and maintainability.

## Architecture

### Core Structure
- `init.lua` - Entry point that sets leader keys and requires core modules
- `lua/options.lua` - Neovim options and settings
- `lua/keymaps.lua` - Basic keymaps and autocommands
- `lua/lazy-bootstrap.lua` - Lazy.nvim plugin manager bootstrap
- `lua/lazy-plugins.lua` - Plugin specification and setup

### Plugin Organization
All plugins are modularized in `lua/plugins/` directory:
- `lspconfig.lua` - LSP configuration with custom keybindings using `<leader>c` prefix
- `gitsigns.lua` - Git integration with `<leader>g` prefix keybindings
- `fzf-lua.lua` - Fuzzy finder (replaces telescope in this fork)
- `blink-cmp.lua` - Completion engine
- `treesitter.lua` - Syntax highlighting and parsing
- `conform.lua` - Code formatting
- `which-key.lua` - Keymap helper
- Other plugins for specific functionality

### Key Conventions
- **Leader key**: Space (` `)
- **LSP keybindings**: All use `<leader>c` prefix (e.g., `<leader>cd` for definitions, `<leader>ca` for code actions)
- **Git keybindings**: All use `<leader>g` prefix  
- **Keymap style**: Direct `vim.keymap.set()` calls (no helper functions)
- **Buffer-local keymaps**: LSP and Git keymaps are buffer-local using `{ buffer = bufnr }`

## Development Guidelines

### Keymap Conventions
- Always use `vim.keymap.set()` directly instead of helper functions
- LSP keymaps should be buffer-local with `<leader>c` prefix
- Git keymaps should be buffer-local with `<leader>g` prefix
- Include descriptive `desc` field for all keymaps

### Plugin Configuration
- Each plugin should have its own file in `lua/plugins/`
- Use lazy.nvim's plugin specification format
- Include proper dependencies and configuration in plugin specs
- Mason is used for LSP server, linter, and formatter installation

### LSP Configuration
- LSP servers are configured in `lspconfig.lua`
- Uses Mason for automatic installation
- Blink.cmp provides completion capabilities
- Custom keybindings are set in LspAttach autocmd

### Code Style
- Use 2-space indentation
- Include vim modeline: `-- vim: ts=2 sts=2 sw=2 et`
- Well-documented with inline comments
- Prefer explicit configuration over defaults

## Dependencies

### External Requirements
- Neovim (latest stable/nightly)
- Git, make, unzip, C compiler
- ripgrep, fd-find
- Clipboard tool (platform-specific)
- Optional: Nerd Font (enabled via `vim.g.have_nerd_font = true`)

### Language-Specific
- npm (for TypeScript/JavaScript)
- go (for Go development)
- Language servers are auto-installed via Mason

## Plugin Management

- Uses lazy.nvim for plugin management
- `lazy-lock.json` tracks exact plugin versions
- Plugins can be enabled/disabled by commenting/uncommenting in `lazy-plugins.lua`
- Use `:Lazy` to manage plugins interactively

## Customization Notes

This configuration prioritizes:
- Minimal, well-documented setup
- Modular organization
- Teaching-friendly structure
- Easy extensibility

When modifying, maintain the educational nature and clear documentation that makes this configuration accessible to Neovim newcomers.
