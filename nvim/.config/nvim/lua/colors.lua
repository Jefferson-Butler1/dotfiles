vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/catppuccin/nvim" },
})

vim.api.nvim_create_user_command("Vague", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme "vague"
  vim.cmd(":hi statusline guibg=NONE")
end, {})

vim.api.nvim_create_user_command("Dark", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme "catppuccin-mocha"
end, {})

vim.api.nvim_create_user_command("Light", function()
  vim.o.background = 'light'
  vim.cmd.colorscheme "catppuccin-latte"
end, {})

-- Default color scheme
vim.cmd("Dark")
