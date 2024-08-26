return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
        -- add any opts here
        provider = "openai",
        hints = { enabled = false },
    },
    keys = {
        { "<leader>A", '<cmd>AvanteAsk<cr>', mode = { "n" }, desc = "Ask Avante" }
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        { "KingMichaelPark/age.nvim", lazy = true },
    },
    config = function(_, opts)
        local identity = vim.fn.expand('$HOME/.config/sops/age/keys.txt')
        if vim.fn.filereadable(identity) == 1 then
            local secret = vim.fn.expand('$HOME/.dotfiles/access.json')
            vim.env.OPENAI_API_KEY = require('age').from_sops(secret)["OPENAI"]
            require("avante").setup(opts)
        end
    end,
}
