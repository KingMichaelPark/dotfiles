return {
    "jackMort/ChatGPT.nvim",
    enabled = true,
    keys = {
        { "<leader>Cc", '<cmd>ChatGPT<cr>', desc = "ChatGPT", },
        { "<leader>Ce", { "n", "v" }, '<cmd>ChatGPTEditWithInstruction<cr>', desc = "ChatGPT" },
        { "<leader>Cd",{ "n", "v" }, "<cmd>ChatGPTRun docstring<CR>", desc="Docstring"  },
        { "<leader>Ct",{ "n", "v" }, "<cmd>ChatGPTRun add_tests<CR>", desc="Add Tests"  },
        { "<leader>Co",{ "n", "v" }, "<cmd>ChatGPTRun optimize_code<CR>", desc="Optimize code"  },
        { "<leader>Cs",{ "n", "v" }, "<cmd>ChatGPTRun summarize<CR>", desc="Optimize code"  },
        { "<leader>Cx",{ "n", "v" }, "<cmd>ChatGPTRun explain_code<CR>", desc="Explain code"  },
        { "<leader>Cf",{ "n", "v" }, "<cmd>ChatGPTRun fix_bugs<CR>", desc="Fix bugs"  },
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
        {"nvim-telescope/telescope.nvim", lazy = true},
        { "KingMichaelPark/age.nvim", lazy = true },
    }
}
