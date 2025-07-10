return {
  'rmagatti/auto-session',
  config = function()
    -- Set session options to include localoptions for proper filetype/highlighting
    vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    
    require('auto-session').setup({
      auto_session_enable_last_session = true,
      auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
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
  end
}