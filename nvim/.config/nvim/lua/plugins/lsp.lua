local servers = {
    "biome",
    "pyright",
    "ruff",
    "terraformls",
}

local function prefix()
    if vim.fn.has("nvim-0.10") == 1 then
        return ""
    else
        return "󰻃 "
    end
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "KingMichaelPark/mason.nvim", opts = { pip = { use_uv = true } } },
        "KingMichaelPark/mason-lspconfig.nvim",
        "nvim-telescope/telescope.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    -- Diagnostic Options
    opts = {
        update_in_insert = false,
        virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = prefix(),
        },
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = "󰗖 ",
                [vim.diagnostic.severity.HINT] = "󰘥 ",
                [vim.diagnostic.severity.INFO] = "󰋽 ",
            },
        },
    },
    config = function(_, opts)
        vim.diagnostic.config(opts)
        local lsp = require("lspconfig")
        require("mason-lspconfig").setup({ ensure_installed = servers })
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

            callback = function(args)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
                end

                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                map("gT", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                map(
                    "<leader>h",
                    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end,
                    "Inlay [H]ints"
                )
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                else
                    if client.name == 'ruff' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                    if client.supports_method("textDocument/formatting") then
                        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = args.buf })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format()
                            end,
                        })
                    end
                end
            end,
        })

        lsp.biome.setup({
            capabilities = capabilities,
        })
        -- Elixir
        lsp.elixirls.setup({
            capabilities = capabilities,
            cmd = { "/Users/mike/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
        })

        lsp.gopls.setup({
            capabilities = capabilities,
        })

        -- Lua
        lsp.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_width = 1,
                        },
                    },
                    hint = {
                        enable = true,
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
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        ignore = { '*' },
                    },
                },
            },
        })

        lsp.ruff.setup({
            capabilities = capabilities,
            init_options = {
                settings = {
                    args = {
                        "--extend-select",
                        "A,ARG,B,C4,DTZ,F,FBT,FURB,G,I,N,PT,S,UP",
                        "--unfixable",
                        "F401,F841",
                    },
                },
            },
        })

        lsp.terraformls.setup({
            capabilities = capabilities,
            filetypes = { "terraform", "hcl" },
        })

        lsp.ts_ls.setup({
            capabilities = capabilities,
        })
    end,
}
