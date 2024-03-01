return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
        vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
        vim.keymap.set("n", "<leader>tq", "<cmd>TodoQuickFix<cr>", { desc = "Todo QuickFix" })
        vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Todo Telescope" })
        require("todo-comments").setup()
    end
}
