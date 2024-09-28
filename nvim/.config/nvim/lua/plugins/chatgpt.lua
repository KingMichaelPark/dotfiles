return {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    keys = {
        { "<leader>Cc", '<cmd>ChatGPT<cr>',                    desc = "ChatGPT", },
        { "<leader>Ca", '<cmd>ChatGPTActAs<cr>',               desc = "ChatGPT Act As", },
        { "<leader>Ce", '<cmd>ChatGPTEditWithInstruction<cr>', mode = { "v", "n" },     desc = "Edit with Instructions" },
        { "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>",       mode = "v",              desc = "Docstring" },
        { "<leader>Ct", "<cmd>ChatGPTRun add_tests<CR>",       mode = "v",              desc = "Add Tests" },
        { "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>",   mode = "v",              desc = "Optimize code" },
        { "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>",       mode = "v",              desc = "Optimize code" },
        { "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>",    mode = "v",              desc = "Explain code" },
        { "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>",        mode = "v",              desc = "Fix bugs" },
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
                    model = "gpt-4o-mini",
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
