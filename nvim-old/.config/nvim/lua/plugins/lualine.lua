return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "palenight",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { "branch" },
        lualine_x = { "lsp_status" },
        lualine_y = { { "filename", path = 1 } },
        lualine_z = { "progress", "location" },
      },
      extensions = { "fugitive", "lazy" },
    })
  end,
}
