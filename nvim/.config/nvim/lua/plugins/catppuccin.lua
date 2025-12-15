return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            float = {
                transparent = true, -- enable transparent floating windows
                solid = false,      -- use solid styling for floating windows, see |winborder|
            },
            flavour = "mocha",      -- latte, frappe, macchiato, mocha
            background = {          -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = true,     -- shows the '~' characters after the end of buffers
            term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false,           -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15,         -- percentage of the shade to apply to the inactive window
            },
            no_italic = false,             -- Force no italic
            no_bold = false,               -- Force no bold
            no_underline = false,          -- Force no underline
            styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" },   -- Change the style of comments
                conditionals = { "bold" },
                loops = { "bold" },
                functions = {},
                keywords = { "bold" },
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                blink_cmp = true,
                diffview = true,
                gitsigns = true,
                harpoon = true,
                fzf = true,
                treesitter = true,
                leap = true,
                mason = true,
                nvim_surround = true,
                snacks = {
                    enabled = true,
                    indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                },
                telescope = { enabled = false },
                which_key = true
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin-mocha"
    end
}
