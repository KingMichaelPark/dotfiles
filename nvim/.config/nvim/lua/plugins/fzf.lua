return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "echasnovski/mini.icons" },
    keys = {
        -- Top Pickers & Explorer
        { "<leader>fb",      function() require('fzf-lua').buffers() end,                                       desc = "Buffers" },
        { "<leader>:",       function() require('fzf-lua').command_history() end,                               desc = "Command History" },
        -- find
        { "<leader>fc",      function() require('fzf-lua').files({ cwd = vim.fn.stdpath("config") }) end,       desc = "Find Config File" },
        { "<leader>ff",      function() require('fzf-lua').files({ hidden = true, args = {} }) end,             desc = "Find Files" },
        { "<leader><space>", function() require('fzf-lua').git_files({ untracked = false, hidden = true }) end, desc = "Find Git Files" },
        { "<c-p>",           function() require('fzf-lua').files({ hidden = true, args = {} }) end,             desc = "Find Files" },
        { "<leader>fp",      function() require('fzf-lua').projects() end,                                      desc = "Projects" },
        -- git
        { "<leader>gl",      function() require('fzf-lua').git_log() end,                                       desc = "Git Log" },
        { "<leader>gL",      function() require('fzf-lua').git_log_line() end,                                  desc = "Git Log Line" },

        {
            "<leader>fa",
            function()
                -- The action handler to open the selected file
                local diff_edit_action = function(selected, _)
                    local filepath = selected[1]
                    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                end

                require('fzf-lua').fzf_exec("git status --porcelain | cut -c 4-", {
                    prompt = "󰜘 > ",
                    file_icons = true,
                    -- Use the 'builtin' previewer for Neovim's floating window
                    previewer = "builtin",
                    -- Add the action to open the file on <CR>
                    actions = {
                        ['default'] = diff_edit_action,
                    },
                    formatter = { "path.filename_first", 2 },
                })
            end,
            desc = "List [f]iles [a]ctive in this revision"
        },

        -- Grep
        { "<leader>/",  function() require('fzf-lua').lines() end,                desc = "Buffer Lines" },
        {
            "<leader>fr",
            function()
                require('fzf-lua').live_grep({
                    hidden = true,
                    rg_opts =
                    "--no-heading --color=always --smart-case --max-columns=4096 --glob !**/.git/** -n --column -e"
                })
            end,
            desc = "Grep Native"
        },
        {
            "<leader>fR",
            function()
                require('fzf-lua').live_grep_glob({
                    hidden = true,
                    rg_opts =
                    "--no-heading --color=always --smart-case --max-columns=4096 --glob !**/.git/** -n --column -e"
                })
            end,
            desc = "Grep Glob"
        },
        { "<leader>fw", function() require('fzf-lua').grep_cWORD() end,           desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s/', function() require('fzf-lua').search_history() end,       desc = "Search History" },
        { "<leader>sb", function() require('fzf-lua').lines() end,                desc = "Buffer Lines" },
        { "<leader>sh", function() require('fzf-lua').command_history() end,      desc = "Command History" },
        { "<leader>s/", function() require('fzf-lua').commands() end,             desc = "Commands" },
        { "<leader>fd", function() require('fzf-lua').diagnostics() end,          desc = "Diagnostics" },
        { "<leader>fh", function() require('fzf-lua').help_tags() end,            desc = "Help Pages" },
        { "<leader>fk", function() require('fzf-lua').keymaps() end,              desc = "Keymaps" },
        { "<leader>fm", function() require('fzf-lua').man_pages() end,            desc = "Man Pages" },
        -- LSP
        { "gd",         function() require('fzf-lua').lsp_definitions() end,      desc = "Goto Definition" },
        { "gD",         function() require('fzf-lua').lsp_declarations() end,     desc = "Goto Declaration" },
        { "gr",         function() require('fzf-lua').lsp_references() end,       desc = "References" },
        { "gI",         function() require('fzf-lua').lsp_implementations() end,  desc = "Goto Implementation" },
        { "gy",         function() require('fzf-lua').lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    },
    opts = {
        defaults = { formatter = { "path.filename_first", 2 } },
        winopts = {
            -- border argument passthrough to nvim_open_win()
            border   = "rounded",
            -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
            backdrop = 100
        },
        keymap = {
            fzf = {
                ['ctrl-q'] = 'select-all+accept',
            },
        },
    }
}
