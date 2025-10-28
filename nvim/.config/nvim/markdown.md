# Neovim Configuration Spec

## Vim Options
- Line numbers: absolute + relative
- No line wrapping
- 2-space tabs (soft)
- Sign column always visible
- Smart/auto indent with breakindent
- Scroll offset: 50 lines
- No swap files, persistent undo enabled
- Smart case-insensitive search
- Visible list characters (tabs, trailing spaces, nbsp)
- Rounded window borders
- True color support
- Leader key: `<Space>`

## Core Keymaps
- `<Esc>` - Clear search highlight
- `<leader>rl` - Reload init.lua
- `<leader>w` - Write file
- `<leader>q` - Quit
- `<leader>y` - Yank to system clipboard (n/v/x)
- `<leader>p` - Paste from system clipboard (n/v/x)

## Color Schemes
- **vague.nvim** (default)
- **catppuccin-macchiato** (`:Dark`)
- **rose-pine-dawn** (`:Light`)
- nvim-highlight-colors for color code highlighting

## File Navigation
- **Oil.nvim** - `<leader>e` (shows hidden files)
- **Mini.pick** - Fuzzy finder
  - `<leader>ff` - Files
  - `<leader>fg` - Live grep
  - `<leader>fb` - Buffers
  - `<leader>h` - Help

## LSP
- **Mason** - LSP manager
- **Treesitter** - typescript, tsx, lua, bash, rust
- **Language Servers**: lua_ls, ts_ls, bash_ls, rust_analyzer
- **Keymaps**:
  - `<leader>rn` - Rename
  - `<leader>ca` - Code action
  - `gd` - Definition
  - `gr` - References
  - `gi` - Implementation
  - `gt` - Type definition

## Diagnostics
- `<leader>dd` - Document diagnostics (current buffer)
- `<leader>da` - Workspace diagnostics (all buffers)
- `<leader>dc` - Diagnostic float (current line)

## Formatting (Conform)
- Format on save (500ms timeout, LSP fallback)
- **JS/TS/TSX/JSX**: eslint_d → prettierd
- **CSS/SCSS/HTML**: prettierd
- **JSON/JSONC/Markdown**: prettierd
- **Lua**: stylua
- **Rust**: rustfmt
- **TOML**: taplo

## Completion
- **Blink.cmp** - Default setup

## UI Plugins
- **Lualine** - Status line (mode, diff, diagnostics, branch, LSP, filename, progress)
- **Which-key** - Keymap helper
- **Gitsigns** - Inline git blame (author, date, summary at EOL, 100ms delay)
- **Mini.animate** - Animations
- **Hardtime** - Movement improvement

## Session Management
- **Auto-session** - Branch-specific sessions
- Location: `~/.local/share/nvim/sessions/`
- Suppressed dirs: `~/`, `~/Projects`, `~/Downloads`, `/`

## Terminal (Toggleterm)
- `<leader>tt` - Generic floating terminal
- `<leader>tc` - Claude CLI
- `<leader>gg` - Lazygit

## Other
- **WakaTime** - Time tracking
- **nvim-web-devicons** - File icons
- Highlight on yank (autocmd)