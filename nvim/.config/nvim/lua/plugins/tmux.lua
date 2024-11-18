return {
  "aserowy/tmux.nvim",
  lazy = false,
  config = function()
    local tmux = require("tmux")
    tmux.setup({})
  end,
}
