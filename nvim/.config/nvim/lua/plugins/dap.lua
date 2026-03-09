return {
    {
        "igorlfs/nvim-dap-view",
        dependencies = {
            { "mfussenegger/nvim-dap",           event = "VeryLazy" },
            { "mfussenegger/nvim-dap-python",    event = "VeryLazy" },
            { "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
        },
        keys = {
            { "<leader>Do", function() require("dap-view").toggle() end,                 desc = "Toggle DAP View" },
            { "<leader>Da", function() require("dap-view").add_expr() end,               mode = { "n", "v" },       desc = "Add expression to watch" },
            { "<leader>Dj", function() require("dap-view").jump_to_view("watches") end,  desc = "Jump to watches" },
            { "<leader>Ds", function() require("dap-view").show_view("scopes") end,      desc = "Show scopes" },
            { "[v",         function() require("dap-view").navigate({ count = -1 }) end, desc = "Previous DAP view" },
            { "]v",         function() require("dap-view").navigate({ count = 1 }) end,  desc = "Next DAP view" },
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
                "<leader>Df",
                function()
                    require("dap-python").test_method()
                    require("dap-view").open()
                end,
                desc = "DAP Test Method",
            },
            {
                "<leader>Dc",
                function()
                    require("dap-python").test_class()
                    require("dap-view").open()
                end,
                desc = "DAP Test Class",
            }
        },
        lazy = false,
        opts = { winbar = { controls = { enabled = true } }, auto_toggle = true, follow_tab = true },
        config = function(_, opts)
            require("dap-view").setup(opts)

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
        end
    },
}
