return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = false,
        sync_on_ui_close = false,
      },
    })

    -- Basic telescope configuration for harpoon v2
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- Navigate to specific files
    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)

    -- Sequential navigation
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

    -- File management
    vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end)
    vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)

    -- Telescope integration (commented out since telescope is removed)
    -- vim.keymap.set("n", "<leader>hm", function() toggle_telescope(harpoon:list()) end)
  end,
}
