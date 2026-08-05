local gh = require("utils").gh

vim.pack.add({ gh("mfussenegger/nvim-dap") })
vim.pack.add({ gh("mfussenegger/nvim-dap-python") })
vim.pack.add({ gh("theHamsta/nvim-dap-virtual-text") })
vim.pack.add({ { src = gh("igorlfs/nvim-dap-view"), version = vim.version.range("1.*") } })

require("dap-view").setup({
    winbar = {
        controls = { enabled = true },
        sections = { "scopes", "repl", "watches", "exceptions", "breakpoints" },
        default_section = "scopes",
        base_sections = {
            -- Labels can be set dynamically with functions
            -- Each function receives the window's width and the current section as arguments
            breakpoints = { label = "", keymap = "B" },
            scopes = { label = "󰭎", keymap = "S" },
            exceptions = { label = "", keymap = "E" },
            watches = { label = "󰖉", keymap = "W" },
            threads = { label = "󱇫", keymap = "T" },
            repl = { label = "", keymap = "R" },
        },
    },
    virtual_text = { enabled = false },
    auto_toggle = true,
    follow_tab = true,
    windows = {
        -- `prev` is the last used position, might be nil
        position = function(prev)
            local wins = vim.api.nvim_tabpage_list_wins(0)

            -- Restores previous position if terminal is visible
            if
                vim.iter(wins):find(function(win)
                    return vim.w[win].dapview_win_term
                end)
            then
                return prev
            end

            return vim.tbl_count(vim.iter(wins)
                :filter(function(win)
                    local buf = vim.api.nvim_win_get_buf(win)
                    local valid_buftype =
                        vim.tbl_contains({ "", "help", "prompt", "quickfix", "terminal" }, vim.bo[buf].buftype)
                    local dapview_win = vim.w[win].dapview_win or vim.w[win].dapview_win_term
                    return valid_buftype and not dapview_win
                end)
                :totable()) > 1 and "below" or "right"
        end,
        size = function(pos)
            return pos == "below" and 0.25 or 0.5
        end,
        terminal = {
            -- `pos` is the position for the regular window
            position = function(pos)
                return pos == "below" and "right" or "below"
            end,
            size = 0.5,
        },
    },
})

require("nvim-dap-virtual-text").setup()

-- Adaptors
local dapy = require("dap-python")
dapy.setup("uv")

vim.fn.sign_define("DapBreakpoint", {
    text = "⚐",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapBreakpointCondition", {
    text = "⚑",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapLogPoint", {
    text = "✦",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapStopped", {
    text = "➜",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapBreakpointRejected", {
    text = "✖",
    texthl = "",
    linehl = "",
    numhl = "",
})

vim.keymap.set("n", "<leader>Do", function() require("dap-view").toggle() end, { desc = "Toggle DAP View" })
vim.keymap.set(
    { "n", "v" },
    "<leader>Da",
    function() require("dap-view").add_expr() end,
    { desc = "Add expression to watch" }
)
vim.keymap.set(
    "n",
    "<leader>Dj",
    function() require("dap-view").jump_to_view("watches") end,
    { desc = "Jump to watches" }
)
vim.keymap.set("n", "<leader>Ds", function() require("dap-view").show_view("scopes") end, { desc = "Show scopes" })
vim.keymap.set("n", "[v", function() require("dap-view").navigate({ count = -1 }) end, { desc = "Previous DAP view" })
vim.keymap.set("n", "]v", function() require("dap-view").navigate({ count = 1 }) end, { desc = "Next DAP view" })
vim.keymap.set("n", "<F6>", '<cmd>lua require("dap").step_into()<cr>', { desc = "DAP Step Into" })
vim.keymap.set("n", "<F7>", '<cmd>lua require("dap").step_over()<cr>', { desc = "DAP Step Over" })
vim.keymap.set("n", "<F8>", '<cmd>lua require("dap").step_out()<cr>', { desc = "DAP Step Out" })
vim.keymap.set("n", "<F9>", '<cmd>lua require("dap").step_back()<cr>', { desc = "DAP Step Back" })
vim.keymap.set("n", "<Leader>b", '<cmd>lua require("dap").toggle_breakpoint()<cr>', { desc = "DAP Toggle Breakpoint" })
vim.keymap.set(
    "n",
    "<Leader>B",
    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "DAP Set Breakpoint Condition" }
)
vim.keymap.set(
    "n",
    "<Leader>Dp",
    function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "DAP Set breakpoint log point" }
)
vim.keymap.set("n", "<leader>Df", function()
    require("dap-python").test_method()
    require("dap-view").open()
end, { desc = "DAP Test Method" })
vim.keymap.set("n", "<leader>Dc", function()
    require("dap-python").test_class()
    require("dap-view").open()
end, { desc = "DAP Test Class" })
