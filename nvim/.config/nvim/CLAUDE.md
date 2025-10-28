# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a modern, minimalist Neovim configuration designed as a single-file setup using native Neovim features (requires Neovim nightly). The entire configuration is contained in `init.lua` with no separate plugin files or complex directory structures.

### Key Design Principles
- **Native-first**: Uses `vim.pack.add()` instead of external plugin managers
- **Minimal plugins**: Focus on essential functionality rather than feature bloat  
- **Modern Neovim**: Leverages latest native LSP and completion features
- **Session-aware**: Auto-session management with git branch integration

## Core Components

### Plugin Management
- Uses native `vim.pack.add()` for plugin installation
- No lazy-loading or complex plugin configuration
- Plugins are configured inline immediately after installation

### Essential Plugins
- **LSP**: `nvim-lspconfig` with lua_ls and ts_ls servers
- **Completion**: `blink.cmp` for modern completion experience
- **File Operations**: `oil.nvim` for file management, `mini.pick` for fuzzy finding
- **Sessions**: `auto-session` with git branch support
- **UI**: Multiple colorschemes (vague, catppuccin), hardtime for movement improvement

### Key Features
- Leader key: `<Space>`
- Session management with git branch awareness
- Built-in LSP formatting (`<leader>bf`)
- Custom colorscheme switching commands (`:Vague`, `:Dark`, `:Light`)

## Common Development Commands

### Neovim Configuration Management
- `:source` or `<leader>rl` - Reload configuration after changes
- Test changes by restarting Neovim or using the reload keymap

### LSP Operations
- `<leader>bf` - Format current buffer using LSP
- `<leader>dd` - Show document diagnostics  
- `<leader>dD` - Show workspace diagnostics

### File Navigation
- `<leader>e` - Open file explorer (Oil)
- `<leader>ff` - Find files (fuzzy finder)
- `<leader>fg` - Live grep search
- `<leader>fb` - Buffer picker
- `<leader>h` - Help picker

### Session Management
- Sessions are automatically saved/restored per git branch
- Use `:SessionSearch` to browse saved sessions
- Sessions stored in `~/.local/share/nvim/sessions/`

## Customization Guidelines

### Adding New Plugins
1. Add to `vim.pack.add()` table with GitHub URL
2. Configure immediately after the plugin installation block
3. Keep configuration inline and minimal

### Modifying LSP Setup
- LSP servers configured via `vim.lsp.enable()` and `vim.lsp.config()`
- Add new servers to the enable list, configure as needed

### Colorscheme Management
- Define custom commands for new colorschemes following existing pattern
- Update default colorscheme by changing `vim.cmd("Vague")` line

This configuration prioritizes simplicity and uses Neovim's latest built-in capabilities over external abstractions.

## Principles and Guidelines
- Dont add descriptions to keybinds