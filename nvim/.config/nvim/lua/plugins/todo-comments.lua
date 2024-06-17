return {
    "folke/todo-comments.nvim",
    dependencies = { {
        "nvim-lua/plenary.nvim", lazy = true }, { "nvim-telescope/telescope.nvim", lazy = true } },
    config = true,
    keys = {
        { "]c",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[c",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<leader>cq", "<cmd>TodoQuickFix<cr>",                             desc = "Todo QuickFix" },
        { "<leader>ct", "<cmd>TodoTelescope<cr>",                            desc = "Todo Telescope" }
    }
}
