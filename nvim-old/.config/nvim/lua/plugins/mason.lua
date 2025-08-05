return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "ts_ls",
                "html",
                "lua_ls",
                "graphql",
                "prismals",
                "eslint",
                "tailwindcss",
                "rust_analyzer",
                "gopls",
                "golangci_lint_ls",
            },
            -- automatically install LSPs with default config
            handlers = {
                ["ts_ls"] = function()
                    require("lspconfig").ts_ls.setup({
                        root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
                        single_file_support = false,
                    })
                end,
                -- Default handler for other servers
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "eslint_d",
                "rustfmt", -- rust formatter
            },
        })
    end,
}
