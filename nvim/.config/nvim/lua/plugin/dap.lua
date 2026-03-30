local gh = require("utils").gh

vim.pack.add({ gh("mfussenegger/nvim-dap") })
vim.pack.add({ gh("mfussenegger/nvim-dap-python") })
vim.pack.add({ gh("theHamsta/nvim-dap-virtual-text") })
vim.pack.add({ gh("igorlfs/nvim-dap-view") })

require("dap-view").setup({ winbar = { controls = { enabled = true } }, auto_toggle = true, follow_tab = true })

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
