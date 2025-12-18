return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                -- Conform will run the first available formatter
                ["javascript.jsx"] = { "biome" },
                ["typescript.tsx"] = { "biome" },
                css                = { "biome" },
                html               = { "biome" },
                javascript         = { "biome" },
                javascriptreact    = { "biome" },
                json               = { "biome" },
                jsonc              = { "biome" },
                jsx                = { "biome" },
                markdown           = { "prettierd" },
                scss               = { "biome" },
                tsx                = { "biome" },
                typescript         = { "biome" },
                typescriptreact    = { "biome" },
                -- yaml               = { "yamlfmt" },
            },
        })
    end
}
