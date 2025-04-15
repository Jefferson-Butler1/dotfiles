return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
  config = function()
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")

    -- Configure telescope
    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        file_ignore_patterns = { "node_modules", ".git" },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden"
        },
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--smart-case"
        },
      },
    })


    -- vim.keymap.set("n", "<leader>ff", builtin.find_files, {})                -- Uses rg by default
    -- vim.keymap.set("n", "<leader>fb", function() builtin.buffers({ sort_lastused = true }) end, {})
    -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})                 -- Uses rg by default
    -- vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})                  -- Recent files
    -- vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})               -- Search word under cursor
    -- vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {}) -- Search in current buffer
    -- vim.keymap.set("n", "<leader>ft", builtin.treesitter, {})                -- Browse treesitter symbols
  end,
}
