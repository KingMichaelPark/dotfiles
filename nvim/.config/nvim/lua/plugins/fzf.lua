return {
    "ibhagwan/fzf-lua",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({
            defaults = {
                formatter = { "path.filename_first", 2 }
            },
            actions = {
                ['ctrl-g'] = { require('fzf-lua.actions').toggle_ignore },
            },
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
            },
            previewers = {
                builtin = {
                    syntax_limit_b = 1024 * 100, -- 100KB
                },
            },
        })
        fzf.register_ui_select()
    end,
    keys = {
        { "<C-p>",      "<cmd>lua require('fzf-lua').git_files()<cr>",                               desc = "Git files" },
        { "<leader>/",  "<cmd>lua require('fzf-lua').lgrep_curbuf()<cr>",                            desc = "Buffer search" },
        { "<leader>fR", "<cmd>lua require('fzf-lua').live_grep_glob()<cr>",                          desc = "Ripgrep w/ Glob" },
        { "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<cr>",                                 desc = "Buffers" },
        { "<leader>fc", "<cmd>lua require('fzf-lua').git_commits()<cr>",                             desc = "Commits" },
        { "<leader>fd", "<cmd>lua require('fzf-lua').diagnostics_document()<cr>",                    desc = "Diagnostics" },
        { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>",                                   desc = "Find All Files" },
        { "<leader>fh", "<cmd>lua require('fzf-lua').helptags()<cr>",                                desc = "Help" },
        { "<leader>fh", "<cmd>lua require('fzf-lua').manpages()<cr>",                                desc = "Man Pages" },
        { "<leader>fj", "<cmd>lua require('fzf-lua').command_history()<cr>",                         desc = "History" },
        { "<leader>fk", "<cmd>lua require('fzf-lua').keymaps()<cr>",                                 desc = "Keymaps" },
        { "<leader>fl", "<cmd>lua require('fzf-lua').lsp_references()<cr>",                          desc = "Lsp References" },
        { "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles({cwd_only=true, stat_file=true})<cr>", desc = "Old files" },
        { "<leader>fr", "<cmd>lua require('fzf-lua').live_grep_native()<cr>",                        desc = "Ripgrep" },
        { "<leader>fs", "<cmd>lua require('fzf-lua').grep_cWORD()<cr>",                              desc = "Grep String" },
    },
}
