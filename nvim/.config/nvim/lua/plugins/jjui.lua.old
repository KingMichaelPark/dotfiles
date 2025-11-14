return {
    'akinsho/toggleterm.nvim',
    version = "*", -- or a specific tag like 'v2.11.0'
    config = function()
        -- Basic setup for toggleterm
        require("toggleterm").setup({
            open_mapping = [[<c-\>]], -- Main toggle key
            direction = 'float',      -- Default direction for new terminals
            start_in_insert = true,   -- Start in insert mode
            persist_size = true,      -- Remember terminal size
            close_on_exit = true,     -- Close window when a process exits
            float_opts = {
                -- Options for floating windows
                border = 'curved',
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
                -- Make it a large, centered float
                width = function() -- CHANGED
                    return math.floor(vim.o.columns * 0.8)
                end,
                height = function() -- CHANGED
                    return math.floor(vim.o.lines * 0.8)
                end,
            },
        })

        -- === Custom Terminal for jjui ===
        -- Based on the lazygit example

        -- 1. Require the Terminal class
        local Terminal = require('toggleterm.terminal').Terminal

        -- 2. Create a new terminal instance for jjui
        local jjui_term = Terminal:new({
            cmd = "jjui",        -- The command to run
            dir = "git_dir",     -- Start in the repo root
            direction = "float", -- Ensure it's always a float
            hidden = false,      -- Hide from default ToggleTerm commands
            -- Set specific options for this float
            float_opts = {
                border = 'double',
                title_pos = 'center',
                width = function() -- CHANGED
                    return math.floor(vim.o.columns * 0.9)
                end,
                height = function() -- CHANGED
                    return math.floor(vim.o.lines * 0.9)
                end,
            },
            -- Function to run when the terminal opens
            on_open = function(term)
                -- Enter insert mode automatically
                -- vim.cmd("startinsert!")
                -- Add keymaps to close the window with 'q' or '<esc>'
                -- These are buffer-local to the terminal
            end,
        })

        -- 3. Create a global function to toggle the terminal
        function _G.toggle_jjui()
            jjui_term:toggle()
        end

        -- 4. Map a key to toggle the jjui terminal
        -- You can change '<leader>jj' to your preferred keymap
        vim.keymap.set("n", "<leader>jj", "<cmd>lua _G.toggle_jjui()<CR>", {
            noremap = true,
            silent = true,
            desc = "Toggle jjui (Jujutsu)"
        })
        vim.keymap.set("n", "<leader>gg", "<cmd>lua _G.toggle_jjui()<CR>", {
            noremap = true,
            silent = true,
            desc = "Toggle jjui (Jujutsu)"
        })
    end,
}
