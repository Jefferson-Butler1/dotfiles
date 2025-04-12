vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.g.mapleader = " "
vim.opt.swapfile = false

-- side line numbers are relative
vim.wo.number = true
vim.wo.relativenumber = true

-- Use system clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Save undo history between sessions
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
vim.opt.scrolloff = 20

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_set_keymap("n", "zz", ":w | :bp | bd #<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":bprevious<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("WriteNoHooks", function()
  vim.cmd("set eventignore=BufWritePre")
  vim.cmd("write")
  vim.cmd("set eventignore=")
end, {})
vim.cmd([[cnoreabbrev wn w<bar>n]])
vim.cmd("cabbrev wn WriteNoHooks")

vim.api.nvim_create_user_command("CWD", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print(path)
end, {})
vim.cmd("cabbrev cwd CWD")

vim.api.nvim_create_user_command("BDA", function()
  vim.fn.expand("%bd|e#")
end, {})
vim.cmd("cabbrev bda BDA")
