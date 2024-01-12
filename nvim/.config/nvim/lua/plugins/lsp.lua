local on_attach = function(client, bufnr) 
    local opts = { buffer = bufnr }
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'


    -- Buffer local mappings.
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<leader>p', function() vim.lsp.buf.format { async = true } end, opts)
end
local servers = {
    "biome",
    "pyright",
    "terraformls",
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
        },
        severity_sort = true,
        inlay_hints = {
            enabled = false,
        }
    },
    config = function(_, opts)
        local lsp = require("lspconfig")
        require("mason-lspconfig").setup({ ensure_installed = servers })
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        lsp.biome.setup({
            server = opts,
            on_attach = on_attach,
            capabilities = capabilities,

        })
        -- Elixir
        lsp.elixirls.setup({
            server = opts,
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "/Users/mike/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
        })

        -- Lua
        lsp.lua_ls.setup({
            server = opts,
            capabilities = capabilities,
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
        })

        lsp.pyright.setup({
            server = opts,
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lsp.terraformls.setup({
            filetypes = { "terraform", "hcl" },
            server = opts,
            on_attach = on_attach,
            capabilities = capabilities
        })

        lsp.tsserver.setup({
            server = opts,
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
}
