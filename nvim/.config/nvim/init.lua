-- ============================================================================
-- VIM OPTIONS
-- ============================================================================
vim.o.number         = true
vim.o.relativenumber = true
vim.o.wrap           = false
vim.o.expandtab      = true
vim.o.tabstop        = 2
vim.o.softtabstop    = 2
vim.o.shiftwidth     = 2
vim.o.signcolumn     = "yes"
vim.o.autoindent     = true
vim.o.smartindent    = true
vim.o.breakindent    = true

vim.o.swapfile       = false
vim.o.undofile       = true

vim.o.ignorecase     = true
vim.o.smartcase      = true

vim.o.list           = true
vim.opt.listchars    = { tab = "» ", trail = "·", nbsp = "␣", extends = "›", precedes = "‹" }
vim.o.winborder      = "rounded"
vim.o.scrolloff      = 50
vim.g.mapleader      = " "

vim.api.nvim_create_autocmd("TextYankPost", { callback = vim.hl.on_yank })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set('n', '<leader>rl', ':update<CR> :source ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')

vim.opt.termguicolors = true
-- ============================================================================
-- PLUGIN INSTALLATION
-- ============================================================================
vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.extra" },
  { src = "https://github.com/echasnovski/mini.animate" },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/m4xshen/hardtime.nvim' },
  { src = "https://github.com/rmagatti/auto-session" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/sphamba/smear-cursor.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/wakatime/vim-wakatime" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
  { src = "https://github.com/stevearc/conform.nvim" },
})

-- ============================================================================
-- COLORS
-- ============================================================================

require('nvim-highlight-colors').setup({})
vim.api.nvim_create_user_command("Vague", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme "vague"
  vim.cmd(":hi statusline guibg=NONE")
end, {})

vim.api.nvim_create_user_command("Dark", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme "catppuccin-macchiato"
end, {})

vim.api.nvim_create_user_command("Light", function()
  vim.o.background = 'light'
  vim.cmd.colorscheme "rose-pine-dawn"
end, {})

-- Default color scheme
vim.cmd("Vague")

-- ============================================================================
-- FILE EXPLORER (OIL)
-- ============================================================================
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================
require "mason".setup()
---@diagnostic disable-next-line: missing-fields
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "tsx", "lua", "bash" },
  highlight = { enable = true, },
}

vim.lsp.enable({ "lua_ls", "ts_ls", "bash_ls" })
vim.lsp.config("lua_ls",
  {
    settings = {
      Lua = {
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        }
      }
    }
  }
)

vim.keymap.set("n", "<leader>bf", function()
  require("conform").format({ lsp_format = "fallback" })
end)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)

-- ============================================================================
-- CONFORM (FORMATTING)
-- ============================================================================
require("conform").setup({
  formatters_by_ft = {
    javascript = { "eslint_d", "prettierd" },
    javascriptreact = { "eslint_d", "prettierd" },
    typescript = { "eslint_d", "prettierd" },
    typescriptreact = { "eslint_d", "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    markdown = { "prettierd" },
  },
  
  format_on_save = {
    timeout_ms = 2000,
    lsp_format = "fallback",
  },
})

-- ============================================================================
-- BLINK.CMP (COMPLETION)
-- ============================================================================
require('blink.cmp').setup()

-- ============================================================================
-- MINI.PICK (FUZZY FINDER)
-- ============================================================================
require "mini.pick".setup()
require('mini.extra').setup()
require('mini.animate').setup()

vim.keymap.set("n", "<leader>ff", ":Pick files <CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")

-- Document diagnostics using mini.extra
vim.keymap.set('n', '<leader>dd', function()
  require('mini.extra').pickers.diagnostic({
    scope = 'current' -- Show diagnostics for current buffer only
  })
end, { desc = 'Document diagnostics' })

vim.keymap.set('n', '<leader>dD', function()
  require('mini.extra').pickers.diagnostic({
    scope = 'all' -- Show diagnostics for all buffers
  })
end, { desc = 'Workspace diagnostics' })

vim.keymap.set('n', '<leader>dc', vim.diagnostic.open_float, { desc = "Diagnostic, current" })

-- ============================================================================
-- HARDTIME (MOVEMENT IMPROVEMENT)
-- ============================================================================
require("hardtime").setup({})

-- ============================================================================
-- SMEAR-CURSOR (CURSOR TRAILING EFFECT)
-- ============================================================================
-- require("smear_cursor").setup()

-- ============================================================================
-- LUALINE
-- ============================================================================
require("lualine").setup({
  options = {
    theme = "auto",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "diff", "diagnostics" },
    lualine_c = { "branch" },
    lualine_x = { "lsp_status" },
    lualine_y = { { "filename", path = 1 } },
    lualine_z = { "progress", "location" },
  },
})

-- ============================================================================
-- WHICH-KEY
-- ============================================================================
require("which-key").setup()

-- ============================================================================
-- GITSIGNS
-- ============================================================================
require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text_pos = "eol",
    delay = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
})

-- ============================================================================
-- AUTO-SESSION
-- ============================================================================
require "auto-session".setup(
  {
    auto_create = true,
    auto_restore = true,
    auto_restore_last_session = false,
    auto_save = true,
    enabled = true,
    git_use_branch_name = true,
    log_level = "error",
    root_dir = "/Users/jeff/.local/share/nvim/sessions/",
    session_lens = {
      buftypes_to_ignore = {},
      load_on_setup = true,
      picker_opts = {
        border = true
      },
      previewer = false
    },
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" }
  }
)


-- ============================================================================
-- TOGGLE-TERM
-- ============================================================================
local Terminal = require('toggleterm.terminal').Terminal
Lazygit        = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
Term           = Terminal:new({ hidden = true, direction = "float" })
Claude         = Terminal:new({ cmd = "claude --resume || claude", direction = "float" })
BTOP           = Terminal:new({ cmd = "btop", direction = "float" })

vim.keymap.set({ "n", "t" }, "<leader>tt", "<CMD>lua Term:toggle()<CR>")
vim.keymap.set({ "n", "t" }, "<leader>tc", "<CMD>lua Claude:toggle()<CR>")
vim.keymap.set({ "n", "t" }, "<leader>gg", "<CMD>lua Lazygit:toggle()<CR>")
