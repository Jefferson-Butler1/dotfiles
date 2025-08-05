
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.pick" },
})
require "mini.pick".setup()
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")

