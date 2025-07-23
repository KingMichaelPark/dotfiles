return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "echasnovski/mini.icons" },
    keys = {
        -- Top Pickers & Explorer
        { "<leader>fb", function() require('fzf-lua').buffers() end,                                 desc = "Buffers" },
        { "<leader>:",  function() require('fzf-lua').command_history() end,                         desc = "Command History" },
        -- find
        { "<leader>fc", function() require('fzf-lua').files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() require('fzf-lua').files({ hidden = true, args = {} }) end,       desc = "Find Files" },
        {
            "<leader><space>",
            function()
                local success, _ = pcall(require('fzf-lua').git_files({ untracked = false, hidden = true }))
                if not success then
                    require('fzf-lua').files({ hidden = true, args = {} })
                end
            end,
            desc = "Find Git Files"
        },
        { "<leader>fg", function() require('fzf-lua').git_files({ untracked = false, hidden = true }) end, desc = "Find Git Files" },
        { "<leader>fp", function() require('fzf-lua').projects() end,                                      desc = "Projects" },
        -- git
        { "<leader>gl", function() require('fzf-lua').git_log() end,                                       desc = "Git Log" },
        { "<leader>gL", function() require('fzf-lua').git_log_line() end,                                  desc = "Git Log Line" },
        -- Grep
        { "<leader>/",  function() require('fzf-lua').lines() end,                                         desc = "Buffer Lines" },
        { "<leader>fr", function() require('fzf-lua').live_grep_native({ hidden = true }) end,             desc = "Grep Native" },
        { "<leader>fR", function() require('fzf-lua').live_grep_glob({ hidden = true }) end,               desc = "Grep Glob" },
        { "<leader>fw", function() require('fzf-lua').grep_word() end,                                     desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s/', function() require('fzf-lua').search_history() end,                                desc = "Search History" },
        { "<leader>sb", function() require('fzf-lua').lines() end,                                         desc = "Buffer Lines" },
        { "<leader>sh", function() require('fzf-lua').command_history() end,                               desc = "Command History" },
        { "<leader>s/", function() require('fzf-lua').commands() end,                                      desc = "Commands" },
        { "<leader>fd", function() require('fzf-lua').diagnostics() end,                                   desc = "Diagnostics" },
        { "<leader>fh", function() require('fzf-lua').help_tags() end,                                     desc = "Help Pages" },
        { "<leader>fk", function() require('fzf-lua').keymaps() end,                                       desc = "Keymaps" },
        { "<leader>fm", function() require('fzf-lua').man_pages() end,                                     desc = "Man Pages" },
        -- LSP
        { "gd",         function() require('fzf-lua').lsp_definitions() end,                               desc = "Goto Definition" },
        { "gD",         function() require('fzf-lua').lsp_declarations() end,                              desc = "Goto Declaration" },
        { "gr",         function() require('fzf-lua').lsp_references() end,                                desc = "References" },
        { "gI",         function() require('fzf-lua').lsp_implementations() end,                           desc = "Goto Implementation" },
        { "gy",         function() require('fzf-lua').lsp_type_definitions() end,                          desc = "Goto T[y]pe Definition" },
    },
    opts = {
        defaults = { formatter = { "path.filename_first", 2 } },
        keymap = {
            fzf = {
                ['ctrl-q'] = 'select-all+accept',
            },
        },
    }
}
