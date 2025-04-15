return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "palenight",
			},
			-- for sure @edit this. This is the bottom status bar, see their git repo for all the options. it can be pretty cool
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff", "diagnostics" },
				lualine_c = {
					function()
						return vim.fn.getcwd()
					end,
				},
				lualine_x = {},
				lualine_y = { "fileName" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
