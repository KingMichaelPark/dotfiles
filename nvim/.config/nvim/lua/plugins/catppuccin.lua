return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            term_colors = false,
            styles = {
                comments = { "italic" },
                keywords = { "bold" },
                types = { "italic" },
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                blink_cmp = true,
                cmp = false,
                dadbod_ui = false,
                diffview = true,
                gitsigns = true,
                harpoon = true,
                mason = true,
                nvim_surround = true,
                nvimtree = false,
                telescope = false,
                fzf = true,
                leap = true,
                treesitter = true,
                notify = false,
                which_key = true,
            },
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
