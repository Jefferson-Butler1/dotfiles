return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    -- Global LSP keymaps (Mason handles server setup)
    vim.keymap.set("n", "<leader>dc", vim.diagnostic.open_float, { desc = "Show diagnostic" })
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "Rename" })
    vim.keymap.set("n", "<D-.>", vim.lsp.buf.code_action, { desc = "code_action" })
    
    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  end,
}
