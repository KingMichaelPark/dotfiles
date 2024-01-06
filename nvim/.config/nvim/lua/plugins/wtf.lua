local identity = vim.fn.expand('$HOME/.age/identity.txt')
local secret = vim.fn.expand('$HOME/.dotfiles/chatgpt.age')

return {
    "piersolenski/wtf.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "KingMichaelPark/age.nvim"
    },
    keys = {
        { "gw", 'lua require("wtf").ai()', desc = "Debug diagnostic with AI" },
        { "gW", 'require("wtf").search()', desc = "Search diagnostic with DDG" },
    },
    config = function()
        require("wtf").setup({
            search_engine = "duck_duck_go",
            openai_api_key = require('age').get(secret, identity),
        })
    end
}
