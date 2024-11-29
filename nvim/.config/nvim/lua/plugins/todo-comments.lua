return {
    "folke/todo-comments.nvim",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            lazy = true,
        },
        { "nvim-telescope/telescope.nvim", lazy = true },
    },
    config = true,
    keys = {
        {
            "]T",
            function() require("todo-comments").jump_next() end,
            desc = "Next [T]odo comment",
        },
        {
            "[T",
            function() require("todo-comments").jump_prev() end,
            desc = "Previous [T]odo comment",
        },
        { "<leader>Tq", "<cmd>TodoQuickFix<cr>",  desc = "[T]odo [q]uickFix" },
        { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "[f]ind [T]odo with Telescope" },
    },
}
