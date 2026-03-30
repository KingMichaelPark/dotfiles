local gh = require("utils").gh

vim.pack.add({ gh("echasnovski/mini.icons") })
vim.pack.add({ gh("ibhagwan/fzf-lua") })

require("fzf-lua").setup({
    defaults = { formatter = { "path.filename_first", 2 } },
    winopts = {
        -- border argument passthrough to nvim_open_win()
        border = "rounded",
        -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
        backdrop = 100,
    },
    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept",
        },
    },
})

-- Top Pickers & Explorer
vim.keymap.set("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>:", function() require("fzf-lua").command_history() end, { desc = "Command History" })
-- find
vim.keymap.set(
    "n",
    "<leader>fc",
    function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find Config File" }
)
vim.keymap.set(
    "n",
    "<leader>ff",
    function() require("fzf-lua").files({ hidden = true, args = {} }) end,
    { desc = "Find Files" }
)
vim.keymap.set(
    "n",
    "<leader><space>",
    function() require("fzf-lua").git_files({ untracked = false, hidden = true }) end,
    { desc = "Find Git Files" }
)
vim.keymap.set(
    "n",
    "<c-p>",
    function() require("fzf-lua").files({ hidden = true, args = {} }) end,
    { desc = "Find Files" }
)
vim.keymap.set("n", "<leader>fp", function() require("fzf-lua").projects() end, { desc = "Projects" })
-- git
vim.keymap.set("n", "<leader>gl", function() require("fzf-lua").git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function() require("fzf-lua").git_log_line() end, { desc = "Git Log Line" })

vim.keymap.set("n", "<leader>fa", function()
    -- The action handler to open the selected file
    local diff_edit_action = function(selected, _)
        local filepath = selected[1]
        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    end

    require("fzf-lua").fzf_exec("git status --porcelain | cut -c 4-", {
        prompt = "󰜘 > ",
        file_icons = true,
        -- Use the 'builtin' previewer for Neovim's floating window
        previewer = "builtin",
        -- Add the action to open the file on <CR>
        actions = {
            ["default"] = diff_edit_action,
        },
        formatter = { "path.filename_first", 2 },
    })
end, { desc = "List [f]iles [a]active in this revision" })

vim.keymap.set("n", "<leader>fn", function()
    local nerd_icons = require("utils.nerd_icons")
    local items = {}
    for _, item in ipairs(nerd_icons.list()) do
        table.insert(items, string.format("%s  %s", item.char, item.name))
    end
    require("fzf-lua").fzf_exec(items, {
        prompt = "  ",
        multiselect = true,
        winopts = {
            height = 0.40,
            width = 0.60,
        },
        actions = {
            ["default"] = function(selected)
                local icons = {}
                for _, line in ipairs(selected) do
                    local icon = vim.fn.split(line, "  ")[1]
                    table.insert(icons, icon)
                end
                vim.api.nvim_put({ table.concat(icons, "") }, "c", true, true)
            end,
        },
    })
end, { desc = "Find Nerd Font Icon" })

-- Grep
vim.keymap.set("n", "<leader>/", function() require("fzf-lua").lines() end, { desc = "Buffer Lines" })
vim.keymap.set(
    "n",
    "<leader>fr",
    function()
        require("fzf-lua").live_grep({
            hidden = true,
            rg_opts = "--no-heading --color=always --smart-case --max-columns=4096 --glob !**/.git/** -n --column -e",
        })
    end,
    { desc = "Grep Native" }
)
vim.keymap.set(
    "n",
    "<leader>fR",
    function()
        require("fzf-lua").live_grep_glob({
            hidden = true,
            rg_opts = "--no-heading --color=always --smart-case --max-columns=4096 --glob !**/.git/** -n --column -e",
        })
    end,
    { desc = "Grep Glob" }
)
vim.keymap.set(
    { "n", "x" },
    "<leader>fw",
    function() require("fzf-lua").grep_cWORD() end,
    { desc = "Visual selection or word" }
)
-- search
vim.keymap.set("n", "<leader>s/", function() require("fzf-lua").search_history() end, { desc = "Search History" })
vim.keymap.set("n", "<leader>sb", function() require("fzf-lua").lines() end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sh", function() require("fzf-lua").command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>s/", function() require("fzf-lua").commands() end, { desc = "Commands" })
vim.keymap.set("n", "<leader>fd", function() require("fzf-lua").diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>fk", function() require("fzf-lua").keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fm", function() require("fzf-lua").man_pages() end, { desc = "Man Pages" })
-- LSP
vim.keymap.set("n", "gd", function() require("fzf-lua").lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function() require("fzf-lua").lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function() require("fzf-lua").lsp_references() end, { desc = "References" })
vim.keymap.set("n", "gI", function() require("fzf-lua").lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function() require("fzf-lua").lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
