return {
	-- Base package manager
	{
		"williamboman/mason.nvim",
		opts = { PATH = "append" }, -- Ensures Mason binaries are found
	},

	-- LSP Management
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"ts_ls", -- TS/JS
				"lua_ls", -- Lua
				"bashls", -- Bash
				"yamlls", -- YAML
			},
		},
	},

	-- Formatter/Linter Management
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				-- Formatters
				"prettierd", -- TS/JS/JSON/YAML
				"shfmt", -- Shell
				"stylua", -- Lua
				-- Linters
				"eslint_d", -- TS/JS
				"shellcheck", -- Shell
				"dotenv_linter", -- .env
			},
			automatic_installation = true,
		},
	},

	-- LSP/Formatting Engine
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			-- Shared capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LSP Servers (filetype-specific)
			require("lspconfig").ts_ls.setup({ capabilities = capabilities })
			require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			require("lspconfig").bashls.setup({ capabilities = capabilities })
			require("lspconfig").yamlls.setup({ capabilities = capabilities })

			-- Null-ls (formatters/linters)
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Formatting
					null_ls.builtins.formatting.prettierd.with({
						filetypes = { "javascript", "typescript", "json", "yaml" },
					}),
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.stylua,

					-- Linting
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.diagnostics.dotenv_linter,
				},
			})

			-- Universal keymaps
			vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format buffer" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })

			-- -- Auto-format on save
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			-- 	callback = function()
			-- 		if not vim.tbl_contains({ "text", "markdown" }, vim.bo.filetype) then
			-- 			vim.lsp.buf.format({ async = false })
			-- 		end
			-- 	end,
			-- })
		end,
	},
}
