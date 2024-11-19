return {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
        require('lint').linters_by_ft = {
            terraform = { 'tflint', 'trivy', },
            tf = { 'tflint', 'trivy', },
            yml = { 'actionlint' },
            yaml = { 'actionlint' },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                -- try_lint without arguments runs the linters defined in `linters_by_ft`
                -- for the current filetype
                require("lint").try_lint()
            end
        })
    end
}
