return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,  -- Lua
        null_ls.builtins.formatting.prettierd, -- JS/TS
        require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.formatting.shellharden, -- bash?
        null_ls.builtins.formatting.isort,   -- python
        null_ls.builtins.formatting.black,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
