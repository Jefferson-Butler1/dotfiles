local vim            = vim
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
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')


require "colors"
require "lsp"
require "mini-pick"
require "files"
require "sessions"
