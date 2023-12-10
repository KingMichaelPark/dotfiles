return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { "catppuccin/nvim", name = "catppuccin" },
    },
    config = function()
        local colors = require("catppuccin.palettes.mocha")
        local bubbles = { left = "", right = "" }
        local modes = {
            "mode",
            fmt = function(str) return str:sub(1, 1) end,
            color = { bg = colors.base, fg = colors.surface2 },
        }
        local filename = {
            "filename",
            color = { bg = colors.blue, fg = colors.base },
            separator = bubbles,
            path = 4
        }
        local filetype = {
            "filetype",
            icon_only = true,
            color = { bg = colors.base, fg = colors.lavender },
            separator = bubbles,
        }
        local branch = {
            "branch",
            color = { bg = colors.base, fg = colors.teal },
            separator = bubbles,
        }
        local diff = {
            "diff",
            color = { bg = colors.base, fg = colors.text },
            separator = bubbles,
        }
        local diagnostics = {
            "diagnostics",
            color = { bg = colors.base, fg = colors.text },
            separator = bubbles,
        }

        local dc = { fg = colors.text, bg = colors.base }
        local a2z = {
            a = dc,
            b = dc,
            c = dc,
            x = dc,
            y = dc,
            z = dc
        }
        local c_theme = { normal = a2z, insert = a2z, visual = a2z }

        require("lualine").setup({
            extensions = { "nvim-dap-ui", "lazy" },
            options = {
                icons_enabled = true,
                theme = c_theme,
                section_separators = { left = "", right = "" },
                always_divide_middle = true,
                globalstatus = true,
                disabled_filetypes = { statusline = { "alpha" } },
            },
            sections = {
                lualine_a = { modes },
                lualine_b = { filename, filetype },
                lualine_c = { diagnostics },
                lualine_x = { branch },
                lualine_y = { diff },
                lualine_z = {},
            },
        })
    end,
}
