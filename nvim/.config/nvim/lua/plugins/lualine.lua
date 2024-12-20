return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local custom = require("lualine.themes.catppuccin-mocha")
        local modes = {"insert", "normal", "command", "visual", "replace", "terminal", "inactive"}
        for _, mode in ipairs(modes) do
            custom[mode].b.bg = "NONE"
        end

        -- Change the background of lualine_c section for normal mode
        require("lualine").setup({
            options = {
                theme = custom,
                component_separators = { left = "", right = "",  },
                section_separators = { left = "", right = "" }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "%f" },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { "branch", "diff", "diagnostics" },
                lualine_z = {},
            },
        })
    end,
}
