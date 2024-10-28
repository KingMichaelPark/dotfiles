return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                border = "curved",
                width = function() return math.ceil(vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) * 0.95) end,
                height = function()
                    return math.ceil(vim.api.nvim_win_get_height(vim.api.nvim_get_current_win()) * 0.95)
                end,
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
        })

        function Lazygit_toggle() lazygit:toggle() end

        local norm = Terminal:new({
            dir = "git_dir",
            direction = "horizontal",
            count = 5432,
        })

        function Lazygit_toggle() lazygit:toggle() end

        function Norm_toggle() norm:toggle() end

        function GetVisualSelection()
            -- Note that this makes no effort to preserve this register
            vim.cmd('noau normal! "vy"')
            return vim.fn.getreg("v")
        end

        function BufferToString()
            local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
            return table.concat(content, "\n")
        end

        vim.keymap.set(
            "n",
            "<leader>gg",
            "<cmd>lua Lazygit_toggle()<CR>",
            { noremap = true, silent = true, desc = "LazyGit" }
        )
        vim.keymap.set(
            "v",
            "<leader>tv",
            "<cmd>lua require('toggleterm').exec(GetVisualSelection(), 5432)<CR>",
            { noremap = true, silent = true, desc = "Send Visual Selection to Term" }
        )
        vim.keymap.set(
            { "v", "n" },
            "<leader>tb",
            "<cmd>lua require('toggleterm').exec(BufferToString(), 5432)<CR>",
            { noremap = true, silent = true, desc = "Send Entire Buffer to Term" }
        )
    end,
}
