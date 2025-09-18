return {
    "laytan/cloak.nvim",
    keys = {
        { "<leader>ct", "<cmd>:CloakToggle<cr>",  desc = "[c]loak [t]oggle" },
        { "<leader>ce", "<cmd>:CloakEnable<cr>",  desc = "[c]loak [e]nable" },
        { "<leader>cd", "<cmd>:CloakDisable<cr>", desc = "[c]loak [d]isable" }
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
