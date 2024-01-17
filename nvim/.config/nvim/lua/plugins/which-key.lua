return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>D"] = {
                name = "DAP Debug",
            },
            ["<leader>f"] = {
                name = "Telescope",
            },
            ["<leader>g"] = {
                name = "Git",
            },
            ["<leader>d"] = {
                name = "DiffView",
            },
            ["<leader>c"] = {
                name = "LSP Code Actions",
            },
            ["<leader>w"] = {
                name = "LSP Workspace",
            },
            ["<leader>s"] = {
                name = "Spectre",
            },
            ["<leader>m"] = {
                name = "Harpoon",
            },
            ["<leader>t"] = {
                name = "Toggle",
            },
            ["<leader>x"] = {
                name = "Quickfix & Loclist",
            },
        })
    end,
}
