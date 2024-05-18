return {
    "jackMort/ChatGPT.nvim",
    enabled = true,
    keys = {
        { "<leader>Cc", '<cmd>ChatGPT<cr>',                    desc = "ChatGPT", },
        { "<leader>Ca", '<cmd>ChatGPTActAs<cr>',               desc = "ChatGPT Act As", },
        { "<leader>Ce", '<cmd>ChatGPTEditWithInstruction<cr>', { "n", "v" },            desc = "ChatGPT" },
        { "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>",       { "n", "v" },            desc = "Docstring" },
        { "<leader>Ct", "<cmd>ChatGPTRun add_tests<CR>",       { "n", "v" },            desc = "Add Tests" },
        { "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>",   { "n", "v" },            desc = "Optimize code" },
        { "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>",       { "n", "v" },            desc = "Optimize code" },
        { "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>",    { "n", "v" },            desc = "Explain code" },
        { "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>",        { "n", "v" },            desc = "Fix bugs" },
    },
    config = function()
        local identity = vim.fn.expand('$HOME/.config/sops/age/keys.txt')
        if vim.fn.filereadable(identity) == 1 then
            local secret = vim.fn.expand('$HOME/.dotfiles/access.json')
            vim.env.OPENAI_API_KEY = require('age').from_sops(secret)["OPENAI"]

            require("chatgpt").setup({
                openai_params = {
                    model = "gpt-4o",
                    max_tokens = 4096
                },
                openai_edit_params = {
                    model = "gpt-3.5-turbo",
                    max_tokens = 4096
                },
            })
        end
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope.nvim", lazy = true },
        { "KingMichaelPark/age.nvim",      lazy = true },
    }
}
