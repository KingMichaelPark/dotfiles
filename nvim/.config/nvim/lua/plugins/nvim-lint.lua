return {
    'mfussenegger/nvim-lint',
    event = "VeryLazy",
    config = function()
        local lint = require("lint")
        require('lint').linters_by_ft = {
            terraform = { 'trivy', 'tflint' },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
