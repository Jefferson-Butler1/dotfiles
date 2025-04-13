local termconf = {
  win = {
    relative = "editor",
    style = "terminal",
    border = "rounded",
    row = 0.15,
    col = 0.15,
  }
}

local excludeArgs = {
      hidden = true,    -- Include hidden files
      ignored = true,   -- Include ignored files (based on .gitignore)
      exclude = {
        "target",       -- Rust build directory
        "vendor",       -- Go vendor directory
        ".git",
        "*.lock",
        "*/tmp/*"
      }
    }


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
    picker = { layout = { preset = "telescope" } },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- { "<leader>sn",       function() Snacks.scratch() end,                                          desc = "Toggle Scratch Buffer" },
    -- { "<leader>ss",       function() Snacks.scratch.select() end,                                   desc = "Select Scratch Buffer" },
    -- { "<leader>gl",       function() Snacks.lazygit.log_file() end,                                 desc = "Lazygit Log (cwd)" },
    -- { "<leader>gb",       function() Snacks.git.blame_line() end,                                   desc = "Git Blame" },
    { "<C-g>",            function() Snacks.lazygit() end,                                          desc = "Lazygit" },
    { "<leader><leader>", function() Snacks.picker.smart() end,                                     desc = "Smart Files" },
    { "<leader>ff",       function() Snacks.picker.pick("files") end,                               desc = "Find Files" },
    { "<leader>fh",       function() Snacks.picker.help() end,                                      desc = "Help Pages" },
    { "<leader>fr",       function() Snacks.picker.recent() end,                                    desc = "Find Recent Files" },
    { "<leader>fb",       function() Snacks.picker.buffers() end,                                   desc = "Buffers" },
    { "<leader>fg",       function() Snacks.picker.grep(excludeArgs) end,                           desc = "Grep Files" },
    { "<leader>fw",       function() Snacks.picker.grep_word() end,                                 mode = { "n", "x" } },
    -- { "<leader>ft",       function() Snacks.picker.treesitter() end,                                mode = { "n", "x" } },
    { "<leader>fc",       function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,   desc = "Find Config File" },
    { "<leader>fd",       function() Snacks.picker.files({ cwd = "~/dotfiles", hidden = true }) end, desc = "Find Config File" },
    { "<leader>fm",       function() Snacks.picker.man() end,                                       desc = "Cwd Diagnostics" },
    { "<C-n>",            function() Snacks.explorer() end,                                         desc = "Explorer" },
    --@edit these are kinda odd ones, I use gd a ton, but gr and gD not as much. Still useful though
    { "gd",               function() Snacks.picker.lsp_definitions() end,                           desc = "Goto Definition" },
    -- { "gD",               function() Snacks.picker.lsp_declarations() end,                          desc = "Goto Declaration" },
    -- { "gr",               function() Snacks.picker.lsp_references() end,                            desc = "References",                          nowait = true },
    -- { "gI",               function() Snacks.picker.lsp_implementations() end,                       desc = "Goto Implementation" },
    -- { "gt",               function() Snacks.picker.lsp_type_definitions() end,                      desc = "Goto [T]ype Definition" },
    --@edit these are so fucking useful
    { "<leader>dd",       function() Snacks.picker.diagnostics() end,                               desc = "Cwd Diagnostics" },
    { "<leader>db",       function() Snacks.picker.diagnostics_buffer() end,                        desc = "Buffer Diagnostics" },
    --@edit I think this one is actually worse than the float-term one, so im commenting it for now and rebinding the one in floatterm
    -- { "<C-\\>",           function() Snacks.terminal.toggle(vim.o.shell, termconf) end,             desc = "Toggle Floating Terminal",            mode = { "n", "t" } },
  },
}
