return {
  "folke/snacks.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]],
      },
    },
    indent = { enabled = true },
    input = { enabled = true },
    git = { enabled = true },
    picker = { layout = {preset = "telescope" }} ,
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<leader>sn",       function() Snacks.scratch() end,            desc = "Toggle Scratch Buffer" },
    { "<leader>ss",        function() Snacks.scratch.select() end,     desc = "Select Scratch Buffer" },
    { "<leader>gl",       function() Snacks.lazygit.log_file() end,   desc = "Lazygit Log (cwd)" },
    { "<leader>gb",       function() Snacks.git.blame() end,          desc = "Git Blame" },
    { "<leader>l",       function() Snacks.lazygit() end,            desc = "Lazygit" },
    { "<leader><leader>", function() Snacks.picker.smart() end,      desc = "Smart Files" },
    { "<leader>ff",       function() Snacks.picker.pick("files") end, desc = "Find Files" },
    { "<leader>fb",       function() Snacks.picker.buffers() end,     desc = "Buffers" },
    { "<leader>fg",       function() Snacks.picker.grep() end,        desc = "Grep Files" },
    { "<leader>fw",       function() Snacks.picker.grep_word() end,   mode = { "n", "x" } },
    { "<C-n>",            function() Snacks.explorer() end,           desc = "Explorer" },
  }
}
