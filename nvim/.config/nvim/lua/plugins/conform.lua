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
                ["javascript.jsx"] = { "prettierd" },
                ["typescript.tsx"] = { "prettierd" },
                css                = { "prettierd" },
                html               = { "prettierd" },
                javascript         = { "prettierd" },
                javascriptreact    = { "prettierd" },
                json               = { "prettierd" },
                jsonc              = { "prettierd" },
                jsx                = { "prettierd" },
                markdown           = { "prettierd" },
                scss               = { "prettierd" },
                tsx                = { "prettierd" },
                typescript         = { "prettierd" },
                typescriptreact    = { "prettierd" },
                -- yaml               = { "prettierd" },
            },
        })
    end
}
