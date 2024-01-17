return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            yaml = { 'yamllint' },
            yml = { 'yamllint' }
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
