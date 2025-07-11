return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
        -- Top Pickers & Explorer
        { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
        -- find
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files({ hidden = true, args = {} }) end,       desc = "Find Files" },
        {
            "<leader><space>",
            function()
                local success, _ = pcall(Snacks.picker.git_files({ untracked = false, hidden = true }))
                if not success then
                    Snacks.picker.files({ hidden = true, args = {} })
                end
            end,
            desc = "Find Git Files"
        },
        { "<leader>fg", function() Snacks.picker.git_files({ untracked = false, hidden = true }) end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects({}) end,                                    desc = "Projects" },
        -- git
        { "<leader>gl", function() Snacks.picker.git_log() end,                                       desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end,                                  desc = "Git Log Line" },
        -- Grep
        { "<leader>/",  function() Snacks.picker.lines() end,                                         desc = "Buffer Lines" },
        { "<leader>fr", function() Snacks.picker.grep({ hidden = true }) end,                         desc = "Grep" },
        { "<leader>fw", function() Snacks.picker.grep_word() end,                                     desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s/', function() Snacks.picker.search_history() end,                                desc = "Search History" },
        { "<leader>sb", function() Snacks.picker.lines() end,                                         desc = "Buffer Lines" },
        { "<leader>sh", function() Snacks.picker.command_history() end,                               desc = "Command History" },
        { "<leader>s/", function() Snacks.picker.commands() end,                                      desc = "Commands" },
        { "<leader>fd", function() Snacks.picker.diagnostics() end,                                   desc = "Diagnostics" },
        { "<leader>fh", function() Snacks.picker.help() end,                                          desc = "Help Pages" },
        { "<leader>fk", function() Snacks.picker.keymaps() end,                                       desc = "Keymaps" },
        { "<leader>fm", function() Snacks.picker.man() end,                                           desc = "Man Pages" },
        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,                               desc = "Goto Definition" },
        { "gD",         function() Snacks.picker.lsp_declarations() end,                              desc = "Goto Declaration" },
        { "gr",         function() Snacks.picker.lsp_references() end,                                nowait = true,                     desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,                           desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,                          desc = "Goto T[y]pe Definition" },
        { "<leader>z",  function() Snacks.toggle.zen():toggle() end,                                  desc = "Toggle Zen Mode" } },
    opts = {
        picker = {},
        toggle = {},
        zen = {}
    },
}
