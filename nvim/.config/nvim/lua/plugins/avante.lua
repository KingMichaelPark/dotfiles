return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false,
    keys = {
        {
            "<leader>ad",
            function() require("avante.api").edit("Add docstrings to this selected code") end,
            mode = "v",
            desc = "Avante add docstrings"
        },
        {
            "<leader>at",
            function() require("avante.api").ask("Show me some good unit tests for this code.") end,
            mode = "v",
            desc = "Avante add tests"
        },
    },
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        { "stevearc/dressing.nvim",   lazy = true },
        { "MunifTanjim/nui.nvim",     lazy = true },
        { "KingMichaelPark/age.nvim", lazy = true }
    },
    config = function()
        local identity = vim.fn.expand('$HOME/.config/sops/age/keys.txt')
        if vim.fn.filereadable(identity) == 1 then
            local secret = vim.fn.expand('$HOME/.dotfiles/access.json')
            vim.env.ANTHROPIC_API_KEY = require('age').from_sops(secret)["ANTHROPIC"]

            require("avante").setup({
                provider = "claude",                  -- Recommend using Claude
                auto_suggestions_provider = "gemini", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-3-5-sonnet-20240620",
                    temperature = 0,
                    max_tokens = 4096,
                },
                behaviour = {
                    auto_suggestions = false, -- Experimental stage
                    auto_set_highlight_group = true,
                    auto_set_keymaps = true,
                    auto_apply_diff_after_generation = false,
                    support_paste_from_clipboard = false,
                },
                hints = { enabled = false },
            })
        end
    end
}
