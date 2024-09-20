return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local flake8 = require("none-ls.diagnostics.flake8")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua, -- Lua
				null_ls.builtins.formatting.prettierd, -- JS/TS
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.formatting.shellharden, -- bash?
				null_ls.builtins.formatting.isort, -- python
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.flake8, -- Add this line for Python diagnostics
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
