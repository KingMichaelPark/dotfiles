return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        { "mfussenegger/nvim-dap",           event = "VeryLazy" },
        { "mfussenegger/nvim-dap-python",    event = "VeryLazy" },
        { "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
        { "nvim-neotest/nvim-nio",           event = "VeryLazy" },
        { "folke/lazydev.nvim",              event = "VeryLazy" }
    },
    event = "VeryLazy",
    keys = { -- Keymaps
        {
            "<F6>",
            '<cmd>lua require("dap").step_into()<cr>',
            desc = "DAP Step Into",
        },
        {
            "<F7>",
            '<cmd>lua require("dap").step_over()<cr>',
            desc = "DAP Step Over",
        },
        {
            "<F8>",
            '<cmd>lua require("dap").step_out()<cr>',
            desc = "DAP Step Out",
        },
        {
            "<F9>",
            '<cmd>lua require("dap").step_back()<cr>',
            desc = "DAP Step Back",
        },
        {
            "<Leader>b",
            '<cmd>lua require("dap").toggle_breakpoint()<cr>',
            desc = "DAP Toggle Breakpoint",
        },
        {
            "<Leader>B",
            "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))()<cr>",
            desc = "DAP Set Breakpoint Condition",
        },
        {
            "<Leader>Dp",
            "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))()<cr>",
            desc = "DAP Set breakpoint log point",
        },
        {
            "<Leader>Dr",
            '<cmd>lua require("dap").repl.open()<cr>',
            desc = "DAP Repl Open",
        },
        {
            "<Leader>Dl",
            '<cmd>lua require("dap").run_last()<cr>',
            desc = "DAP Run Last",
        },
        {
            "<Leader>Do",
            '<cmd>lua require("dapui").toggle()<cr>',
            desc = "DAP-UI Toggle",
        },
        {
            "<leader>Df",
            '<cmd>lua require("dap-python").test_method()<cr>',
            desc = "DAP Test Method",
        },
        {
            "<leader>Dc",
            '<cmd>lua require("dap-python").test_class()<cr>',
            desc = "DAP Test Class",
        },
        {
            "<leader>Ds",
            '<cmd>lua require("dap-python").debug_selection()<cr>',
            "v",
            desc = "DAP Test Selection",
        },
    },
    config = function()
        local dapui = require("dapui")
        local dap = require("dap")
        local dapy = require("dap-python")
        dapui.setup()
        require("lazydev").setup({
            library = { "nvim-dap-ui" },
        })
        require("nvim-dap-virtual-text").setup()

        -- Adaptors
        dapy.setup("uv")

        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

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
    end,
}
