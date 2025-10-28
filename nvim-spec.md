# Nvim Config Reproduction Spec

## Package Manager
Native vim.pack.add (requires Neovim nightly)

## Packages
- vague2k/vague.nvim
- saghen/blink.cmp
- mason-org/mason.nvim
- nvim-treesitter/nvim-treesitter
- neovim/nvim-lspconfig
- catppuccin/nvim
- stevearc/oil.nvim
- echasnovski/mini.pick
- echasnovski/mini.extra
- echasnovski/mini.animate
- MunifTanjim/nui.nvim
- m4xshen/hardtime.nvim
- rmagatti/auto-session
- akinsho/toggleterm.nvim
- sphamba/smear-cursor.nvim
- folke/which-key.nvim
- wakatime/vim-wakatime
- nvim-tree/nvim-web-devicons
- nvim-lualine/lualine.nvim
- rose-pine/neovim
- lewis6991/gitsigns.nvim
- brenoprata10/nvim-highlight-colors

## Key Binds
**Leader:** Space

- `<leader>rl` - Reload config
- `<leader>w` - Write
- `<leader>q` - Quit
- `<leader>y` - Copy to clipboard
- `<leader>p` - Paste from clipboard
- `<leader>e` - Oil file manager
- `<leader>ff` - Find files
- `<leader>h` - Help picker
- `<leader>fb` - Buffer picker
- `<leader>fg` - Live grep
- `<leader>bf` - Format buffer
- `<leader>rn` - Rename
- `<leader>ca` - Code actions
- `<leader>dd` - Document diagnostics
- `<leader>dD` - Workspace diagnostics
- `<leader>dc` - Diagnostic float
- `<leader>tt` - Toggle terminal
- `<leader>tc` - Toggle Claude
- `<leader>gg` - Toggle Lazygit
- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `gt` - Go to type definition
- `Esc` - Clear search

## LSP Servers
- lua_ls
- ts_ls

## TreeSitter Languages
- typescript, tsx, lua, bash

## Colorschemes
- Vague (default)
- Catppuccin Macchiato (Dark command)
- Rose Pine Dawn (Light command)

## Options
- Line numbers + relative
- 2 space tabs, expand
- No swap files, undo files enabled
- Smart case search
- Show hidden chars
- 50 line scroll offset
- Sign column always on

## Auto-behavior
- Format + auto-fix on save
- Highlight on yank
- Git branch-based sessions
- Gitsigns with blame

## External Tools
- lazygit
- btop
- claude