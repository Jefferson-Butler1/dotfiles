return {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-ts-autotag').setup({
            enable = true,
            filetypes = { 
                'html', 'javascript', 'typescript', 'javascriptreact', 
                'typescriptreact', 'tsx', 'jsx', 'xml', 'php', 'markdown'
            },
        })
    end,
}
