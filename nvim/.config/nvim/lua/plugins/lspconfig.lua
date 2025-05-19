return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
      },
    },
    {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    {
      "mfussenegger/nvim-lint",
    },
  },
  config = function()
    -- Set up the LSPs
    local lsp_config = require("lspconfig")
    lsp_config.lua_ls.setup {}
    lsp_config.ts_ls.setup {} 

    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = {"eslint_d"},
      javascriptreact = {"eslint_d"},
      typescript= {"eslint_d"},
      typescriptreact= {"eslint_d"},
    }

    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.gitsigns ,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.dotenv_linter,
      },
      -- Format on save enabled
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          -- Auto format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
              lint.try_lint()
            end,
          })
          
          -- Manual format with <leader>bf
          vim.keymap.set("n", "<leader>bf", function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end, { buffer = bufnr, desc = "Format current buffer" })
        end
      end,
    })

  end,

}
