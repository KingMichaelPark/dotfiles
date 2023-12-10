local identity = vim.fn.expand('$HOME/.age/identity.txt')
local secret = vim.fn.expand('$HOME/.dotfiles/chatgpt.age')

return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>Cc", "<cmd>ChatGPT<CR>",                    desc = "ChatGPT" },
        { "<leader>Ce", "<cmd>ChatGPTEditWithInstruction<CR>", { "n", "v" },    desc = "Edit with instruction" },
        { "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>",       { "n", "v" },    desc = "ChatGPT Docstring" },
        { "<leader>Ct", "<cmd>ChatGPTRun add_tests<CR>",       { "n", "v" },    desc = "Add Tests" },
        { "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>",   { "n", "v" },    desc = "Optimize Code" },
        { "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>",       { "n", "v" },    desc = "Summarize", },
        { "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>",        { "n", "v" },    desc = "Fix Bugs", },
    },
    config = function()
        vim.env.OPENAI_API_KEY = require('age').get(secret, identity)

        require("chatgpt").setup({
            openai_params = {
                model = "gpt-4-1106-preview", -- "gpt-4-1106-preview",
                max_tokens = 600              -- 16385,
            },
            openai_edit_params = {
                model = "gpt-3.5-turbo-1106",
            },
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "KingMichaelPark/age.nvim"
    }
}
