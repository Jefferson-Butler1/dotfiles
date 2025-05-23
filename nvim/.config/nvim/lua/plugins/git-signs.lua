return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl` (disabled for performance)
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl` (disabled for performance)
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Git actions begin with <leader>g
        map("n", "<leader>ga", gs.stage_hunk, { desc = "Git: Stage hunk" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Git: Reset hunk" })
        map("v", "<leader>ga", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git: Stage selected hunk" })
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git: Reset selected hunk" })
        map("n", "<leader>gS", gs.stage_buffer, { desc = "Git: Stage buffer" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Git: Undo stage hunk" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "Git: Reset buffer" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Git: Preview hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Git: Blame line (full)" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Git: Diff this" })
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, { desc = "Git: Diff this (~)" })

        -- Additional hunk navigation commands (use ]c and [c for primary nav)
        map("n", "<leader>gn", gs.next_hunk, { desc = "Git: Next hunk" })
        map("n", "<leader>gk", gs.prev_hunk, { desc = "Git: Previous hunk" })

        -- Git toggle actions begin with <leader>gt
        map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Git: Toggle line blame" })
        map("n", "<leader>gtl", gs.toggle_linehl, { desc = "Git: Toggle line highlight" })
        map("n", "<leader>gtw", gs.toggle_word_diff, { desc = "Git: Toggle word highlight" })
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Git: Toggle deleted" })

        -- Git merge resolution
        map("n", "<leader>gm", function()
          vim.cmd("Gitsigns diffthis")
          vim.cmd("diffget LOCAL")
        end, { desc = "Git: Take mine (LOCAL)" })

        map("n", "<leader>gT", function()
          vim.cmd("Gitsigns diffthis")
          vim.cmd("diffget REMOTE")
        end, { desc = "Git: Take theirs (REMOTE)" })
      end,
    })
  end,
}
