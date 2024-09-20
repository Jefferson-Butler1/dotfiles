vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.wo.number = true
vim.wo.relativenumber = true

-- Optional: Add a command to toggle resize mode
vim.api.nvim_create_user_command('ToggleResizeMode', function()
  local resize_mode = vim.b.resize_mode or false
  vim.b.resize_mode = not resize_mode
  if vim.b.resize_mode then
    vim.keymap.set('n', 'h', ':vertical resize -2<CR>', {buffer = true, silent = true})
    vim.keymap.set('n', 'l', ':vertical resize +2<CR>', {buffer = true, silent = true})
    vim.keymap.set('n', 'j', ':resize -2<CR>', {buffer = true, silent = true})
    vim.keymap.set('n', 'k', ':resize +2<CR>', {buffer = true, silent = true})
    print("Resize mode enabled")
  else
    vim.keymap.del('n', 'h', {buffer = true})
    vim.keymap.del('n', 'l', {buffer = true})
    vim.keymap.del('n', 'j', {buffer = true})
    vim.keymap.del('n', 'k', {buffer = true})
    print("Resize mode disabled")
  end
end, {})

-- Optional: Map a key to toggle resize mode
vim.keymap.set('n', '<M-r>', ':ToggleResizeMode<CR>', {silent = true})

vim.schedule(function()
  vim.opt.clipboard = "unnamed,unnamedplus"
end)

-- Enable break indent
-- vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g.clipboard = {
  name = "macOS-clipboard",
  copy = {
    ["+"] = "pbcopy",
    ["*"] = "pbcopy",
  },
  paste = {
    ["+"] = "pbpaste",
    ["*"] = "pbpaste",
  },
  cache_enabled = 0,
}
