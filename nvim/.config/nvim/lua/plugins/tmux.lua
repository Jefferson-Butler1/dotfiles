return {
  "aserowy/tmux.nvim",
  lazy = false,
  config = function()
    local tmux = require("tmux")

    tmux.setup({
      -- Your other tmux configurations can go here
    })

    -- Function to get a safe session name from the current working directory
    local function get_session_name()
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      -- Replace non-alphanumeric characters with underscores
      return cwd:gsub("[^%w]", "_")
    end

    -- Define toggle_float_term function in the global namespace
    _G.toggle_float_term = function()
      -- Check if Floaterm is available
      if vim.fn.exists(":FloatermToggle") == 2 then
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
      else
        print("Floaterm is not available. Please ensure the plugin is installed and loaded.")
      end
    end

    -- Set keybinding to toggle floating terminal
    vim.api.nvim_set_keymap("n", "<C-\\>", "<cmd>lua toggle_float_term()<CR>", { noremap = true, silent = true })

    -- Set Esc to close Floaterm in terminal mode
    vim.api.nvim_set_keymap("t", "<C-\\>", "<C-\\><C-n>:FloatermHide<CR>", { noremap = true, silent = true })
  end,
  dependencies = {
    "voldikss/vim-floaterm",
  },
}
