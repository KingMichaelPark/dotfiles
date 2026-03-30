local gh = require("utils").gh

vim.pack.add({ gh("rafamadriz/friendly-snippets") })
vim.pack.add({ { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") } })

local opts = {
    sources = {
        default = { "lsp", "buffer", "snippets", "path" },
        per_filetype = {
            sql = { "snippets", "buffer" },
            codecompanion = { "codecompanion" },
        },
    },
    appearance = {
        nerd_font_variant = "normal",
    },
    keymap = { preset = "super-tab" },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
        list = {
            max_items = 25,
        },
        menu = {
            draw = {
                padding = { 0, 1 }, -- padding only on right side
                components = {
                    kind_icon = {
                        text = function(ctx) return " " .. ctx.kind_icon .. ctx.icon_gap .. " " end,
                    },
                },
            },
        },
        -- Displays a preview of the selected item on the current line
        ghost_text = {
            enabled = true,
            show_with_menu = true,
        },
    },

    -- Experimental signature help support
    signature = {
        enabled = true,
    },
    cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
    },
    fuzzy = {
        prebuilt_binaries = { download = true },
        implementation = "rust",
    },
}

local blink_cmp = require("blink.cmp")
blink_cmp.setup(opts)
