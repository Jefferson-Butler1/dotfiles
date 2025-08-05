vim.pack.add({
  { src = "https://github.com/rmagatti/auto-session" },
})

require "auto-session".setup({
    auto_session_enable_last_session = false, -- Don't restore last session globally
    auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
    auto_session_enabled = true,
    auto_restore_enabled = true,
    auto_save_enabled = true,
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    auto_session_use_git_branch = true,

    -- Session lens (optional - for browsing sessions)
    session_lens = {
      buftypes_to_ignore = {},
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },

    -- Auto save session on exit
    auto_session_create_enabled = true,

    -- Log level (can be 'debug', 'info', 'warn', 'error')
    log_level = 'error',
  })
