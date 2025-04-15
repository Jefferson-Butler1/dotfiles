return {
	-- Base package manager
	{
		"williamboman/mason.nvim",
		opts = { PATH = "append" },
	},
	-- LSP Management
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"yamlls",
				"clangd",
				"rust_analyzer",
			},
		},
	},
	-- Formatter/Linter Management
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"shfmt",
				"stylua",
				"shellcheck",
				"dotenv_linter",
				"rustfmt",
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("lspconfig").rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
						procMacro = {
							enable = true,
						},
						cargo = {
							allFeatures = true,
						},
					},
				},
			})

			require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			require("lspconfig").bashls.setup({ capabilities = capabilities })
			require("lspconfig").yamlls.setup({ capabilities = capabilities })

			-- Null-ls setup with explicit source ordering
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {

					-- Other formatters
					null_ls.builtins.formatting.shfmt.with({
						extra_args = { "-i", "2", "-ci" }, -- -i 2 = indent with 2 spaces, -ci = indent switch cases
					}),
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.diagnostics.dotenv_linter,
					null_ls.builtins.formatting.rustfmt,
				},
			})

			local format = function()
				vim.lsp.buf.format({
					async = false,
					filter = function(client)
						return true
					end,
				})

				vim.lsp.buf.code_action({
					context = {
						only = { "source.fixAll" },
					},
					range = {
						start = { 0, 0 },
						["end"] = { vim.fn.line("$"), 0 },
					},
				})
			end

			-- Keymaps
			--@edit you'll probably want to rename/reset some of these. See my notes on keybinds
			vim.keymap.set("n", "<leader>bf", format, { desc = "Format buffer and fix all diagnostics" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
			vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "Rename" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
			vim.keymap.set("n", "<D-.>", vim.lsp.buf.code_action, { desc = "code_action" })

			vim.keymap.set(
				"n",
				"<leader>dc",
				vim.diagnostic.open_float,
				{ desc = "Show diagnostic in floating window" }
			)

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					format()
				end,
				desc = "Format before saving",
			})
		end,
	},
}
