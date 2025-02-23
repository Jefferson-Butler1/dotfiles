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
        "eslint",
        "shellcheck",
        "dotenv_linter",
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
      require("lspconfig").lua_ls.setup({ capabilities = capabilities })
      require("lspconfig").bashls.setup({ capabilities = capabilities })
      require("lspconfig").yamlls.setup({ capabilities = capabilities })

      -- Null-ls setup with explicit source ordering
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- ESLint first for diagnostics/fixes
          null_ls.builtins.diagnostics.eslint.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.json",
                "package.json",
              })
            end,
          }),
          null_ls.builtins.code_actions.eslint.with({
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
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.dotenv_linter,
        },
      })

      local format = function()
        vim.notify("Formatting")
        vim.lsp.buf.format({
          async = false,
          filter = function(client)
            vim.notify(client.name)
            return true
          end,
        })

        local diagnostics = vim.diagnostic.get(0)
        local original_pos = vim.api.nvim_win_get_cursor(0)

        if #diagnostics < 1 then
          vim.notify("No diagnostics found")
          return
        end

        table.sort(diagnostics, function(a, b)
          return a.lnum < b.lnum
        end)

        for _, diagnostic in ipairs(diagnostics) do
          vim.api.nvim_win_set_cursor(0, { diagnostic.lnum + 1, diagnostic.col })
          vim.lsp.buf.code_action({
            context = {
              only = { "quickfix", "fix" },
              diagnostics = { diagnostic },
            },
          })
        end

        vim.api.nvim_win_set_cursor(0, original_pos)
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
