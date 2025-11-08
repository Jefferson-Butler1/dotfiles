-- ============================================================================
-- VIM OPTIONS
-- ============================================================================
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.swapfile = false
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "›", precedes = "‹" }
vim.o.winborder = "rounded"
vim.o.scrolloff = 50
vim.g.mapleader = " "

vim.o.cursorline = true
vim.o.updatetime = 50
vim.o.timeoutlen = 30
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.clipboard = "unnamedplus"
vim.o.inccommand = "split"

vim.api.nvim_create_autocmd("TextYankPost", { callback = vim.hl.on_yank })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>rl", ":update<CR> :source ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set({ "n", "v", "x" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n", "v", "x" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n", "v", "x" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n", "v", "x" }, "<C-l>", "<C-w>l")

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p<CR>')

vim.opt.termguicolors = true
-- ============================================================================
-- PLUGIN INSTALLATION
-- ============================================================================
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/echasnovski/mini.animate" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	-- { src = "https://github.com/m4xshen/hardtime.nvim" },
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
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/coder/claudecode.nvim" },
})

-- ============================================================================
-- COLORS
-- ============================================================================

require("nvim-highlight-colors").setup({})
vim.api.nvim_create_user_command("Vague", function()
	vim.o.background = "dark"
	vim.cmd.colorscheme("vague")
	vim.cmd(":hi statusline guibg=NONE")
end, {})

vim.api.nvim_create_user_command("Dark", function()
	vim.o.background = "dark"
	vim.cmd.colorscheme("catppuccin-macchiato")
end, {})

vim.api.nvim_create_user_command("Light", function()
	vim.o.background = "light"
	vim.cmd.colorscheme("rose-pine-dawn")
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
vim.keymap.set("n", "<leader>e", ":Oil<CR>")

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================
require("mason").setup()
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = { "typescript", "tsx", "lua", "bash", "rust", "graphql" },
	highlight = { enable = true },
})

vim.lsp.enable({ "lua_ls", "ts_ls", "bash_ls", "rust_analyzer", "graphql" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", function()
	require("telescope.builtin").lsp_references()
end)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>ds", vim.lsp.buf.signature_help)

-- ============================================================================
-- CONFORM (FORMATTING)
-- ============================================================================
require("conform").setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		css = { "prettierd" },
		graphql = { "prettierd" },
		html = { "prettierd" },
		javascript = { "eslint_d", "prettierd" },
		javascriptreact = { "eslint_d", "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		rust = { "rustfmt" },
		scss = { "prettierd" },
		sh = { "shfmt" },
		toml = { "taplo" },
		typescript = { "eslint_d", "prettierd" },
		typescriptreact = { "eslint_d", "prettierd" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})

-- ============================================================================
-- BLINK.CMP (COMPLETION)
-- ============================================================================
require("blink.cmp").setup()

-- ============================================================================
-- TELESCOPE (FUZZY FINDER)
-- ============================================================================
require("telescope").setup({
	defaults = {
		layout_config = {
			horizontal = { preview_width = 0.55 },
		},
	},
})

require("mini.animate").setup()

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>h", builtin.help_tags)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>dd", builtin.diagnostics)
vim.keymap.set("n", "<leader>dc", vim.diagnostic.open_float)

-- ============================================================================
-- HARDTIME (MOVEMENT IMPROVEMENT)
-- ============================================================================
-- require("hardtime").setup({})

-- ============================================================================
-- SMEAR-CURSOR (CURSOR TRAILING EFFECT)
-- ============================================================================
require("smear_cursor").setup()

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
require("auto-session").setup({
	auto_create = true,
	auto_restore = true,
	auto_restore_last_session = false,
	auto_save = true,
	enabled = true,
	git_use_branch_name = true,
	log_level = "error",
	session_lens = {
		buftypes_to_ignore = {},
		load_on_setup = true,
		picker_opts = {
			border = true,
		},
		previewer = false,
	},
	suppressed_dirs = { "~/", "/" },
})

-- ============================================================================
-- CLAUDE CODE CONFIGURATION
-- ============================================================================
require("claudecode").setup({
	terminal = {
		split_side = "right", -- or "left" based on your preference
		split_width_percentage = 0.50,
	},
})

-- Optional: Add keymaps for Claude Code
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude Code" })
vim.keymap.set("n", "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude Code" })
vim.keymap.set("n", "<C-y>", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept Claude diff" })
vim.keymap.set("n", "<C-n>", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny Claude diff" })
vim.keymap.set("v", "<leader>cs", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude" })

-- ============================================================================
-- TOGGLE-TERM
-- ============================================================================
local Terminal = require("toggleterm.terminal").Terminal
Lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
Term = Terminal:new({ hidden = true, direction = "float" })
Claude = Terminal:new({ cmd = "claude --resume || claude", direction = "float" })
BTOP = Terminal:new({ cmd = "btop", direction = "float" })

vim.keymap.set({ "n", "t" }, "<leader>tt", "<CMD>lua Term:toggle()<CR>")
vim.keymap.set({ "n", "t" }, "<C-c>", "<CMD>lua Claude:toggle()<CR>")
vim.keymap.set({ "n", "t" }, "<leader>gg", "<CMD>lua Lazygit:toggle()<CR>")

-- Image preview keymap (only available in image files)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "svg", "png", "jpg", "jpeg", "gif", "bmp", "webp" },
	callback = function()
		vim.keymap.set("n", "<leader>ts", function()
			local filepath = vim.fn.expand("%:p")
			vim.notify(filepath)
			Terminal:new({
				cmd = "chafa '" .. filepath .. "' && sleep 5",
				direction = "float",
			}):open()
		end, { buffer = true })
	end,
})
