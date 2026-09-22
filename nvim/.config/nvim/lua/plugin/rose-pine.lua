vim.pack.add({
    {
        src = "https://github.com/rose-pine/neovim",
        name = "rose-pine",
    },
})
require("rose-pine").setup({
    variant = "auto",      -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    enable = {
        terminal = true,
        legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
        migrations = true,         -- Handle deprecated options automatically
    },
    styles = {
        bold = true,
        italic = true,
        transparency = true,
    },
    highlight_groups = {
        StatusLineTerm = { bg = "NONE", fg = "NONE", inherit = false },
        StatusLineTermNC = { bg = "NONE", fg = "NONE", inherit = false },
    },
})

vim.cmd("colorscheme rose-pine")
