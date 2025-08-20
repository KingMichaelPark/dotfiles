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
                html = { "prettierd" },
                js = { "prettierd" },
                jsx = { "prettierd" },
                tsx = { "prettierd" },
                svelte = { "prettierd" },
                ts = { "prettierd" },
                markdown = { "prettierd" },
                yaml = { "prettierd" },
            },
        })
    end
}
