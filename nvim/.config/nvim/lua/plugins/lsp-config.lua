return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "tailwindcss",
          "graphql",
          "ts_ls",
          "pyright",
          "rust_analyzer",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setup for each LSP
      local servers = { "lua_ls", "clangd", "tailwindcss", "graphql", "ts_ls", "pyright", "rust_analyzer" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      -- Keymaps
      local opts = { noremap = true, silent = true }
      -- Enhanced go to definition / references
      vim.keymap.set('n', 'gd', function()
        if vim.fn.expand('<cword>') ~= '' then
          local current_word = vim.fn.expand('<cword>')
          vim.lsp.buf.definition()
          if vim.fn.expand('<cword>') == current_word then
            vim.lsp.buf.references()
          end
        else
          vim.lsp.buf.definition()
        end
      end, opts)
      
      -- Other LSP keymaps
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    end
  }
}
