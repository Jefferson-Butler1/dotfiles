return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,

      ensure_installed = { "lua", "c", "javascript", "typescript", "tsx", "styled", "bash" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "typescript", "tsx" },
      },
      --      indent = { enable = true }, -- breaks indents, no clue why. replaced with logic in vim-opts
    })

    -- Set up .env file detection
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = { ".env", ".env.*" },
      callback = function()
        vim.bo.filetype = "sh"
      end
    })

    -- Extend bash parser to be used for .env files
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.bash.used_by = { "sh", "bash", "zsh", "env" }
  end
}
