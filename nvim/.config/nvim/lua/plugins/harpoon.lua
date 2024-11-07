return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		require("harpoon").setup({
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
		})

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<C-y>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<C-u>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<C-i>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<C-o>", function()
			ui.nav_file(4)
		end)
	end,
}
