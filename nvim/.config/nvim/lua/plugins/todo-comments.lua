return {
    "folke/todo-comments.nvim",
    dependencies = { {
        "nvim-lua/plenary.nvim", lazy=true}, {"nvim-telescope/telescope.nvim", lazy=true} },
    config = true,
    keys={
        {"]t", function() require("todo-comments").jump_next() end,  desc = "Next todo comment" },
        {"[t", function() require("todo-comments").jump_prev() end,  desc = "Previous todo comment" },
        {"<leader>tq", "<cmd>TodoQuickFix<cr>",  desc = "Todo QuickFix" },
        {"<leader>tt", "<cmd>TodoTelescope<cr>",  desc = "Todo Telescope" }
    }
}
