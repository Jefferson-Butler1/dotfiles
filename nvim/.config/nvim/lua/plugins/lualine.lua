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
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "fileName" },
        lualine_z = { "progress", "location" },
      },
    })
  end,
}
