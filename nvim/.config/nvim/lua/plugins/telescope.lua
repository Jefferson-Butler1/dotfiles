return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
    config = function()
      local builtin = require("telescope.builtin")

      -- Regular file finding (non-hidden files)
      vim.keymap.set('n', '<leader>ff', function()
        builtin.find_files()
      end, {})

      -- Hidden file finding
      vim.keymap.set('n', '<leader>fh', function()
        require('telescope.builtin').find_files({
          find_command = { 
            "rg",
            "--files",
            "--hidden",
            "--glob", "!.git",
            "--glob", "!node_modules",
            "--no-ignore"
          },
        })
      end, {})

      -- Live grep (searching file contents)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function ()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
