return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    require("harpoon").setup({
      menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
      },
    })
    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    -- Navigate to specific files
    vim.keymap.set("n", "<leader>h1", function()
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<leader>h2", function()
      ui.nav_file(2)
    end)
    vim.keymap.set("n", "<leader>h3", function()
      ui.nav_file(3)
    end)
    vim.keymap.set("n", "<leader>h4", function()
      ui.nav_file(4)
    end)

    -- Sequential navigation
    vim.keymap.set("n", "<leader>hn", ui.nav_next)
    vim.keymap.set("n", "<leader>hp", ui.nav_prev)

    -- File management
    vim.keymap.set("n", "<leader>hd", mark.rm_file)
    vim.keymap.set("n", "<leader>hD", mark.clear_all)

    -- Telescope integration
    vim.keymap.set("n", "<leader>hm", ":Telescope harpoon marks<CR>")
  end,
}
