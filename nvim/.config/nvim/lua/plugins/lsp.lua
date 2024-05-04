local servers = {
    "biome",
    "pyright",
    "ruff_lsp",
    "terraformls",
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvim-telescope/telescope.nvim"
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        virtual_text = {
            spacing = 2,
            source = "if_many",
        },
        severity_sort = true,
        inlay_hints = {
            enabled = vim.fn.has('nvim-0.10') == 1,
        }
    },
    config = function(_, opts)
        vim.diagnostic.config(opts)
        local lsp = require("lspconfig")
        require("mason-lspconfig").setup({ ensure_installed = servers })
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('gT', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            end
        })

        lsp.biome.setup({
            capabilities = capabilities,
        })
        -- Elixir
        lsp.elixirls.setup({
            capabilities = capabilities,
            cmd = { "/Users/mike/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
        })

        -- Lua
        lsp.lua_ls.setup({
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
        })

        -- Python
        lsp.pyright.setup({
            capabilities = capabilities,
            settings = {
                pyright = {
                    -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                    disableTaggedHints = true,
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to
                        -- exclusively use Ruff for linting
                        ignore = { '*' },
                        diagnosticSeverityOverrides = {
                            -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
                            reportUnusedImport = "none"
                        },
                    },
                }
            }
        })

        lsp.ruff_lsp.setup {
            on_attach = function(client, _)
                client.server_capabilities.hoverProvider = false
            end,
            init_options = {
                settings = {
                    -- Any extra CLI arguments for `ruff` go here.
                    args = {
                        "--fix",
                        "--extend-select",
                        "A,ARG,B,C4,DTZ,FBT,FURB,G,I,N,PT,S,UP",
                        "--unfixable",
                        "F401,F841",
                    },

                }
            }
        }

        lsp.terraformls.setup({
            capabilities = capabilities,
            filetypes = { "terraform", "hcl" },
        })

        lsp.tsserver.setup({
            capabilities = capabilities,
        })
    end
}
