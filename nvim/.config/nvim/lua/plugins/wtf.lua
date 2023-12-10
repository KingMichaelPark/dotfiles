local identity = vim.fn.expand('$HOME/.age/identity.txt')
local secret = vim.fn.expand('$HOME/.dotfiles/chatgpt.age')

return {
    "piersolenski/wtf.nvim",
    config = function()
        require("wtf").setup({
            search_engine = "duck_duck_go",
            openai_api_key = require('age').get(secret, identity),
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "KingMichaelPark/age.nvim"
    },
    event = "VeryLazy",
    keys = {
        { "gw",           mode = { "n", "x" }, function() require("wtf").ai() end,     desc = "Debug diagnostic with AI", },
        { mode = { "n" }, "gW",                function() require("wtf").search() end, desc = "Search diagnostic with DDG", },
    },
}
