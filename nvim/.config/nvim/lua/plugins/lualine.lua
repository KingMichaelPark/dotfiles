return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { "catppuccin/nvim", name = "catppuccin" },
    },
    config = function()
        local colors = require("catppuccin.palettes.mocha")
        local bubbles = { left = "", right = "" }
        local modes = {
            "mode",
            fmt = function(str) return str:sub(1, 1) end,
            color = { bg = colors.surface0, fg = colors.lavender },
            seperator = bubbles
        }
        local filename = {
            "filename",
            color = { bg = colors.surface0, fg = colors.blue },
            separator = bubbles,
            path = 4,
        }
        local filetype = {
            "filetype",
            icon_only = true,
            colored = false,
            color = { bg = colors.surface0, fg = colors.mauve },
            separator = bubbles,
        }
        local branch = {
            "branch",
            color = { bg = colors.surface0, fg = colors.teal },
            separator = bubbles,
        }
        local diff = {
            "diff",
            color = { bg = colors.surface0, fg = colors.green },
            separator = bubbles,
        }
        local diagnostics = {
            "diagnostics",
            color = { bg = colors.surface0, fg = colors.mauve },
            separator = { left = "", right = "" },
        }
        local style = { fg = colors.text, bg = nil }
        local default = {
            a = style,
            b = style,
            c = style,
            x = style,
            y = style,
            z = style
        }
        local theme = {
            normal = default,
            insert = default,
            visual = default,
            replace = default,
            inactive = default
        }

        require("lualine").setup({
            extensions = { "nvim-dap-ui", "lazy" },
            options = {
                theme = theme,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                always_divide_middle = true,
                globalstatus = true,
                disabled_filetypes = { statusline = { "alpha" } },
            },
            sections = {
                lualine_a = { modes },
                lualine_b = { filename, },
                lualine_c = { filetype, },
                lualine_x = { diagnostics },
                lualine_y = { diff },
                lualine_z = { branch },
            },
        })
    end,
}
