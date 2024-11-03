return {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>st", "<cmd>:CloakToggle<cr>", desc = "[s]ecret [t]oggle" }
    },
    config = function()
        require("cloak").setup({
            enabled = true,
            cloak_character = "*",
            highlight_group = "Comment",
            cloak_length = nil,
            try_all_patterns = true,
            patterns = {
                {
                    file_pattern = { ".env*", ".mise.toml", "^config$", "^credentials$" },
                    cloak_pattern = '=.+',
                    replace = nil,
                },
            },
        })
    end,
}
