local on_attach = require("formatting").on_attach
local servers = {
    "biome",
    "pyright",
    "rust_analyzer",
    "elixirls",
    "lua_ls",
    "terraformls",
    "tsserver"
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    event = "BufReadPre",
    config = function()
        -- LSP
        local lsp = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        require("mason-lspconfig").setup({ ensure_installed = servers })

        -- Biome
        lsp.biome.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        -- Elixir
        lsp.elixirls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "/Users/mike/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
        })

        -- Lua
        lsp.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false
                    },
                    telemetry = {
                        enable = false,
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        }
                    },
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- Python
        lsp["pyright"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- Terraform
        lsp["terraformls"].setup({
            filetypes = { "terraform", "hcl" },
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lsp["tsserver"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
}
