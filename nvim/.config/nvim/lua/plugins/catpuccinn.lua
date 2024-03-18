return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = false,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",           -- latte, frappe, macchiato, mocha
            styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
                conditionals = { "italic" },
                keywords = { "bold" },
            },
            transparent_background = true,
            integrations = {
                alpha = true,
                cmp = true,
                dap_ui = true,
                gitsigns = true,
                harpoon = true,
                leap = true,
                treesitter_context = true,
                mason = true,
                which_key = true
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
    end
}
