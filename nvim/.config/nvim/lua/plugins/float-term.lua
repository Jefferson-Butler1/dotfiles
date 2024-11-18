return {
  "voldikss/vim-floaterm",
  lazy = false,
  config = function()
    -- Check dependencies
    if vim.fn.executable('tmux') ~= 1 then
      vim.notify("tmux is not installed. Please install tmux first.", vim.log.levels.ERROR)
      return
    end

    -- Get session name based on current working directory
    local function get_session_name()
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return cwd:gsub("[^%w]", "_")
    end

    -- Function to toggle terminal with tmux session
    vim.g.toggle_float_term = function()
      local session_name = get_session_name()

      -- Try to toggle existing Floaterm
      local toggle_result = vim.fn.execute("FloatermToggle " .. session_name)

      -- If no Floaterm window was toggled, create a new one
      if toggle_result == "" then
        -- Create a new tmux session if it doesn't exist
        vim.fn.system(
          "tmux has-session -t "
          .. session_name
          .. " || tmux new-session -d -s "
          .. session_name
          .. " -c "
          .. vim.fn.getcwd()
        )

        -- Open a new Floaterm with the tmux session
        vim.cmd(
          "FloatermNew --name="
          .. session_name
          .. " --title="
          .. session_name
          .. " --height=0.8 --width=0.8 --autoclose=2 tmux attach -t "
          .. session_name
        )
      end
    end

    -- Set up Floaterm preferences
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_position = 'center'

    -- Keybindings
    vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>lua vim.g.toggle_float_term()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:FloatermHide<CR>", { noremap = true, silent = true })
  end,
}
