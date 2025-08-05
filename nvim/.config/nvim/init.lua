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
vim.o.scrolloff      = 20
vim.g.mapleader      = " "

vim.api.nvim_create_autocmd("TextYankPost", { callback = vim.highlight.on_yank })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set('n', '<leader>rl', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')

-- Lazygit in floating terminal
vim.keymap.set('n', '<leader>gg', function()
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })
  
  vim.fn.termopen('lazygit', {
    on_exit = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
  
  vim.cmd('startinsert')
end, { desc = 'Open lazygit' })

-- ============================================================================
-- PLUGIN INSTALLATION
-- ============================================================================
vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.extra" },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/m4xshen/hardtime.nvim' },
  { src = "https://github.com/rmagatti/auto-session" },
})

-- ============================================================================
-- COLORSCHEMES
-- ============================================================================
vim.api.nvim_create_user_command("Vague", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme "vague"
  vim.cmd(":hi statusline guibg=NONE")
end, {})

vim.api.nvim_create_user_command("Dark", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme "catppuccin-mocha"
end, {})

vim.api.nvim_create_user_command("Light", function()
  vim.o.background = 'light'
  vim.cmd.colorscheme "catppuccin-latte"
end, {})

-- Default color scheme
vim.cmd("Vague")

-- ============================================================================
-- FILE EXPLORER (OIL)
-- ============================================================================
require("oil").setup()
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================
vim.lsp.enable({ "lua_ls", "ts_ls" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})
vim.cmd("set completeopt+=noselect")

vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format)

-- ============================================================================
-- MINI.PICK (FUZZY FINDER)
-- ============================================================================
require "mini.pick".setup()
require('mini.extra').setup()

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")

-- Document diagnostics using mini.extra
vim.keymap.set('n', '<leader>dd', function()
  require('mini.extra').pickers.diagnostic({
    scope = 'current'  -- Show diagnostics for current buffer only
  })
end, { desc = 'Document diagnostics' })

vim.keymap.set('n', '<leader>dD', function()
  require('mini.extra').pickers.diagnostic({
    scope = 'all'  -- Show diagnostics for all buffers
  })
end, { desc = 'Workspace diagnostics' })

-- ============================================================================
-- HARDTIME (MOVEMENT IMPROVEMENT)
-- ============================================================================
require("hardtime").setup({})

-- ============================================================================
-- AUTO-SESSION
-- ============================================================================
require "auto-session".setup({
    auto_session_enable_last_session = false, -- Don't restore last session globally
    auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
    auto_session_enabled = true,
    auto_restore_enabled = true,
    auto_save_enabled = true,
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    auto_session_use_git_branch = true,

    -- Session lens (optional - for browsing sessions)
    session_lens = {
      buftypes_to_ignore = {},
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },

    -- Auto save session on exit
    auto_session_create_enabled = true,

    -- Log level (can be 'debug', 'info', 'warn', 'error')
    log_level = 'error',
  })
