return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>fb", function() require('fzf-lua').buffers() end,                desc = "Buffers" },
        { "<leader>:",  function() require('fzf-lua').command_history() end,        desc = "Command History" },
        { "<leader>ff", function() require('fzf-lua').files({ hidden = true }) end, desc = "Find Files" },
        {
            "<leader><space>",
            function()
                require('fzf-lua').git_files({ hidden = true, untracked = true })
            end,
            desc = "Find Git Files"
        },

        -- git
        { "<leader>gc", function() require('fzf-lua').git_commits() end,                       desc = "Git Commits" },
        -- Grep
        { "<leader>/",  function() require('fzf-lua').lines() end,                             desc = "Buffer Lines" },
        { "<leader>fR", function() require('fzf-lua').live_grep_glob({ hidden = true }) end,   desc = "Grep Glob" },
        { "<leader>fr", function() require('fzf-lua').live_grep_native({ hidden = true }) end, desc = "Grep Performant" },
        { "<leader>fw", function() require('fzf-lua').grep_cWORD({ hidden = true }) end,       desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { "<leader>fc", function() require('fzf-lua').commands() end,                          desc = "Commands" },
        { "<leader>fk", function() require('fzf-lua').keymaps() end,                           desc = "Keymaps" },
        { "<leader>fl", function() require('fzf-lua').loclist() end,                           desc = "Location List" },
        { "<leader>fm", function() require('fzf-lua').manpages() end,                          desc = "Man Pages" },
        { "<leader>fq", function() require('fzf-lua').qflist() end,                            desc = "Quickfix List" },
        -- LSP
        { "gd",         function() require('fzf-lua').lsp_definitions() end,                   desc = "Goto Definition" },
        { "gr",         function() require('fzf-lua').lsp_references() end,                    nowait = true,                     desc = "References" },
        { "gI",         function() require('fzf-lua').lsp_implementations() end,               desc = "Goto Implementation" },
        { "gy",         function() require('fzf-lua').lsp_type_definitions() end,              desc = "Goto T[y]pe Definition" },
        { "<leader>fs", function() require('fzf-lua').lsp_document_symbols() end,              desc = "LSP Symbols" },
    },
    opts = {
        keymap = {
            fzf = { ["ctrl-q"] = "select-all+accept" } }
    }
}
