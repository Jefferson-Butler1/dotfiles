-- this is an excerpt on how to name keybinds:
--
-- Naming keybinds is something that is really nice to get a unified
-- ideology on from the beginning so that your commands stay organized
-- and dont become a whole huge mess. As far as my current scheme, I always
-- start user defined commands with <leader> which is the space key, followed
-- by the first letters of the action. Eg: finding a file is <leader>ff meaning:
-- User command to Find a File. If I want to see diagnostics (error/warnings),
-- I use <leader>dd. This is a bit out of pattern, because if I were to have it
-- as <leader>d, then i would be unable to use commands like <leader>dc for
-- diagnostics in the current file. For the most part my commands follow this,
-- but I would strongly reccomend going through and finding all of the ways
-- that I am wrong in this.
--
-- Also, for more system-ish commands, I tend to use control+{a letter}, eg. <C-n>
-- for the file explorer. Funnily enough the n actually came from the initial plugin
-- that I used for file explorers, so <C-n> is a technically incorrect keybind now,
-- it should probably be <C-e>
--
-- As far as different categories, that's pretty much it, just system and user
-- commands. Given the keyboard layout on most windows/linux, I'd probably move the
-- system commands to alt (<A-{key}>)
--
-- -- NEXT STEPS
-- First and foremost, learn the big overarching commands. I'll give a list here,
-- ordered by most used and which came to mind first:
-- <leader><leader> -- smart file search. Fuzzy find across most used files
-- <leader>fr -- finds most recently used files
-- <leader>fg -- fuzzy grep across current directory (any substring of ./**/*.*)
--            -- will match
-- <leader>cc -- comments/uncomments the current line/selection
-- <C-n> opens file explorer
-- <leader>fc -- finds file inside of nvim configuration for easy config tweaking
-- <leader>fd -- finds file inside of ~/dotfile
-- <C-g>      -- opens lazygit

vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true
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
vim.opt.scrolloff = 1

--removes hilights from / or ? searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

--allows for vim motion between panes by adding control key
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- shows you the text you just yanked with a quick hilight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--this is nice for when you have files that you don't want the formatter to fuck up, eg. snacks.lua
vim.api.nvim_create_user_command("WriteNoHooks", function()
	vim.cmd("set eventignore=BufWritePre")
	vim.cmd("write")
	vim.cmd("set eventignore=")
end, {})
vim.cmd([[cnoreabbrev wn w<bar>n]])
vim.cmd("cabbrev wn WriteNoHooks")
