return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local custom = require("lualine.themes.kanagawa")
        local modes = { "insert", "normal", "command", "visual", "replace", "inactive" }
        for _, mode in ipairs(modes) do
            custom[mode].a.bg = "NONE"
            custom[mode].b.bg = "NONE"
            if mode == "normal" or mode == "inactive" then
                custom[mode].c.bg = "NONE"
            end
            custom[mode].a.fg = custom[mode].a.bg
        end

        -- Change the background of lualine_c section for normal mode
        require("lualine").setup({
            options = {
                theme = custom,
                component_separators = { left = "", right = "", },
                section_separators = { left = "", right = "" }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = {},
                lualine_x = { "branch" },
                lualine_y = { "diff" },
                lualine_z = { "diagnostics" },
            },
        })
    end,
}
