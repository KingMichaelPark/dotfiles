return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({})
        fzf.register_ui_select()
    end,
    keys = {
        { "<C-p>",      "<cmd>lua require('fzf-lua').git_files()<cr>",            desc = "Git files" },
        { "<leader>/",  "<cmd>lua require('fzf-lua').lgrep_curbuf()<cr>",         desc = "Buffer search" },
        { "<leader>fR", "<cmd>lua require('fzf-lua').live_grep_glob()<cr>",       desc = "Ripgrep w/ Glob" },
        { "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<cr>",              desc = "Buffers" },
        { "<leader>fc", "<cmd>lua require('fzf-lua').git_commits()<cr>",          desc = "Commits" },
        { "<leader>fd", "<cmd>lua require('fzf-lua').diagnostics_document()<cr>", desc = "Diagnostics" },
        { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>",                desc = "Find All Files" },
        { "<leader>fh", "<cmd>lua require('fzf-lua').helptags()<cr>",             desc = "Help" },
        { "<leader>fh", "<cmd>lua require('fzf-lua').manpages()<cr>",             desc = "Man Pages" },
        { "<leader>fj", "<cmd>lua require('fzf-lua').command_history()<cr>",      desc = "History" },
        { "<leader>fk", "<cmd>lua require('fzf-lua').keymaps()<cr>",              desc = "Keymaps" },
        { "<leader>fl", "<cmd>lua require('fzf-lua').lsp_references()<cr>",       desc = "Lsp References" },
        { "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<cr>",             desc = "Old files" },
        { "<leader>fr", "<cmd>lua require('fzf-lua').live_grep_native()<cr>",     desc = "Ripgrep" },
        { "<leader>fs", "<cmd>lua require('fzf-lua').grep_cWORD()<cr>",           desc = "Grep String" },
    },
}
