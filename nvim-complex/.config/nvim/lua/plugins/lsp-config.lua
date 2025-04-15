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
				"ts_ls",
				"lua_ls",
				"bashls",
				"yamlls",
				"clangd",
				"gopls",
				"rust_analyzer",
			},
		},
	},
	-- Formatter/Linter Management
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"prettierd",
				"shfmt",
				"stylua",
				"eslint_d",
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

			-- LSP Servers with explicit format disabling for TS
			require("lspconfig").ts_ls.setup({
				capabilities = capabilities,
				settings = {
					typescript = {
						format = { enable = false }, -- Disable TS server formatting
						preferences = {
							importModuleSpecifier = "relative",
						},
					},
					javascript = {
						format = { enable = false }, -- Disable JS server formatting
						preferences = {
							importModuleSpecifier = "relative",
						},
					},
				},
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})

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

			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
						gofumpt = true, -- Stricter formatting
						usePlaceholders = true,
						completeUnimported = true,
						matcher = "fuzzy",
						symbolMatcher = "fuzzy",
						buildFlags = { "-tags=test,e2e" },
						directoryFilters = {
							"-node_modules",
							"-vendor",
							"-internal",
						},
					},
				},
			})

			require("lspconfig").golangci_lint_ls.setup({
				capabilities = capabilities,
				filetypes = { "go", "gomod" },
				init_options = {
					command = { "golangci-lint", "run", "--out-format", "json" },
				},
			})

			require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			require("lspconfig").bashls.setup({ capabilities = capabilities })
			require("lspconfig").yamlls.setup({ capabilities = capabilities })
			-- Null-ls setup with explicit source ordering
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- ESLint first for diagnostics/fixes
					null_ls.builtins.diagnostics.eslint_d.with({
						condition = function(utils)
							return utils.root_has_file({
								".eslintrc",
								".eslintrc.js",
								".eslintrc.json",
								"package.json",
							})
						end,
					}),
					null_ls.builtins.code_actions.eslint_d.with({
						prefer_local = "node_modules/.bin",
					}),

					-- Prettier formatting for supported files
					null_ls.builtins.formatting.prettierd.with({
						filetypes = {
							"javascript",
							"typescript",
							"javascriptreact",
							"typescriptreact",
							"json",
							"yaml",
							"markdown",
							"html",
							"css",
							"scss",
						},
						condition = function(utils)
							return utils.root_has_file({
								".prettierrc",
								".prettierrc.json",
								".prettierrc.yml",
								"package.json",
							})
						end,
					}),

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

				-- local diagnostics = vim.diagnostic.get(0)
				-- local original_pos = vim.api.nvim_win_get_cursor(0)
				--
				-- vim.notify(string.format("%d Diagnostics found", #diagnostics))
				-- if #diagnostics < 1 then
				-- 	return
				-- end
				--
				-- table.sort(diagnostics, function(a, b)
				-- 	return a.lnum < b.lnum
				-- end)
				--
				-- for _, diagnostic in ipairs(diagnostics) do
				-- 	vim.api.nvim_win_set_cursor(0, { diagnostic.lnum + 1, diagnostic.col })
				-- 	vim.lsp.buf.code_action({
				-- 		context = {
				-- 			diagnostics = { diagnostic },
				-- 		},
				-- 	})
				-- end
				--
				-- vim.api.nvim_win_set_cursor(0, original_pos)
			end

			-- Keymaps
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
				desc = "Format with Prettier before saving",
			})
		end,
	},
}
