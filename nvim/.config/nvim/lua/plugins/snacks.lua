return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        dashboard = {
            preset = {
                header = [[
             ⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣠⣶⠚⠛⠿⠷⠶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
             ⠀⠀⠀⠀⠀⢀⣴⠟⠉⠀⠀⢠⡄⠀⠀⠀⠀⠀⠉⠙⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀
             ⠀⠀⠀⢀⡴⠛⠁⠀⠀⠀⠀⠘⣷⣴⠏⠀⠀⣠⡄⠀⠀⢨⡇⠀⠀⠀⠀⠀⠀⠀
             ⠀⠀⠀⠺⣇⠀⠀⠀⠀⠀⠀⠀⠘⣿⠀⠀⠘⣻⣻⡆⠀⠀⠙⠦⣄⣀⠀⠀⠀⠀
             ⠀⠀⠀⢰⡟⢷⡄⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢻⠶⢤⡀
             ⠀⠀⠀⣾⣇⠀⠻⣄⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣀⣤⣽
             ⠀⠀⢸⡟⠻⣆⠀⠈⠳⢄⡀⠀⠀⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣬⡿⠁
             ⠀⢀⣿⠃⠀⠹⣆⠀⠀⠀⠙⠓⠿⢧⡀⠀⢠⡴⣶⣶⣒⣛⣲⣤⣼⠋⠀⠀⠀⠀
             ⠀⣼⡏⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠙⠳⠶⠤⠵⣶⠒⠚⠛⠉⠀⠀⠀⠀⠀⠀
             ⢰⣿⡇⠀⠀⠀⠀⠀⠀⠀⣆⠀⠀⠀⠀⠀⠀⠀⢠⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
             ⢿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠘⣦⡀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
             ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣷⡄⠀⠀⠀⠀⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀
             ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡀⠀⠀⠀⢸⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀
             ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀
                ]],
                keys = {
                    { icon = "󰮗", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = "󰧮", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = "󱪞", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = "󱔗", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = "", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = "󰒲", key = "p", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = "", key = "m", desc = "Mason", action = ":Mason" },
                    { icon = "󰈆", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },
        lazygit = {
            config = {
                gui = {
                    nerdFontsVersion = "",
                },
            },
        },
        picker = {
            formatters = {
                file = {
                    filename_first = true, -- display filename before the file path
                },
            },
        },
    },
    keys = {
        { "<leader>fb", function() Snacks.picker.buffers() end,                desc = "Buffers" },
        { "<leader>:",  function() Snacks.picker.command_history() end,        desc = "Command History" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end,                desc = "Buffers" },
        { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
        {
            "<leader><space>",
            function()
                local ok, _ = pcall(function()
                    Snacks.picker.git_files({ hidden = true, untracked = true })
                end)
                if not ok then
                    print("Not a git repository")
                end
            end,

            desc = "Find Git Files"
        },

        -- git
        { "<leader>gc", function() Snacks.picker.git_log() end,                    desc = "Git Log" },
        { "<leader>gs", function() Snacks.picker.git_status() end,                 desc = "Git Status" },
        -- Grep
        { "<leader>/",  function() Snacks.picker.lines() end,                      desc = "Buffer Lines" },
        { "<leader>sb", function() Snacks.picker.grep_buffers() end,               desc = "Grep Open Buffers" },
        { "<leader>fr", function() Snacks.picker.grep({ hidden = true }) end,      desc = "Grep" },
        { "<leader>fw", function() Snacks.picker.grep_word({ hidden = true }) end, desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { "<leader>sc", function() Snacks.picker.command_history() end,            desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end,                   desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,                desc = "Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end,                       desc = "Help Pages" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,                    desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end,                    desc = "Location List" },
        { "<leader>sM", function() Snacks.picker.man() end,                        desc = "Man Pages" },
        { "<leader>sq", function() Snacks.picker.qflist() end,                     desc = "Quickfix List" },
        { "<leader>qp", function() Snacks.picker.projects() end,                   desc = "Projects" },
        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,            desc = "Goto Definition" },
        { "gr",         function() Snacks.picker.lsp_references() end,             nowait = true,                     desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,        desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,       desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                desc = "LSP Symbols" },
        -- Lazygit
        { "<leader>gg", function() Snacks.lazygit.open() end,                      desc = "Lazygit" },
    },
}
