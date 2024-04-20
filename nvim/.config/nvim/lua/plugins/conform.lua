return {
    'stevearc/conform.nvim',
    opts = {},
    event = { "BufNewFile", "BufWritePre" },
    lazy = true,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                -- sql = { "sqlfluff" },
                shell = { "shfmt" },
                -- terraform = { "terraform_fmt" },
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            }
        })
    end
}
