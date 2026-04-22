local gh = require("utils").gh

vim.pack.add({ gh("stevearc/conform.nvim") })

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
        html               = { "prettierd" },
        javascript         = { "biome" },
        javascriptreact    = { "biome" },
        json               = { "biome" },
        jsonc              = { "biome" },
        jsx                = { "biome" },
        -- markdown = { "prettierd" },
        scss               = { "biome" },
        tsx                = { "biome" },
        typescript         = { "biome" },
        typescriptreact    = { "biome" },
        yaml               = { "prettierd" },
    },
})
