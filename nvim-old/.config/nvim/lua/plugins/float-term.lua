return {
	"voldikss/vim-floaterm",
	lazy = false,
	config = function()
		-- Create a floating terminal in Neovim's current working directory
		vim.g.toggle_float_term = function()
			-- Get current working directory from Neovim
			local cwd = vim.fn.getcwd()

			-- Toggle or create terminal in CWD
			vim.cmd(
				"FloatermNew --wintype=float --name=floaterm --title=floaterm --height=0.8 --width=0.8 --cwd=" .. cwd
			)
		end

		-- Floaterm appearance settings
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.8
		vim.g.floaterm_position = "center"
		vim.g.floaterm_title = "floaterm: $1/$2"
		vim.g.floaterm_autoclose = 2 -- Close on exit

		-- Keybindings (simplified)
		-- vim.api.nvim_set_keymap(
		-- 	"n",
		-- 	"<C-t>",
		-- 	"<cmd>lua vim.g.toggle_float_term()<CR>",
		-- 	{ noremap = true, silent = true }
		-- )
		-- vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:FloatermHide<CR>", { noremap = true, silent = true })
	end,
}
