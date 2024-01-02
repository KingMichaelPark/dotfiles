return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",           -- latte, frappe, macchiato, mocha
            dim_inactive = {
                enabled = true,          -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15,       -- percentage of the shade to apply to the inactive window
            },
            styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
            },
            integrations = {
                cmp = true,
                harpoon = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = "surface1", -- catppuccin color (eg. `lavender`) Default: text
                    colored_indent_levels = false,
                },
                leap = true,
                mason = true,
                which_key = true
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
    end
}
