return {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = false,
    opts_extend = { "sources.default" },
    dependencies = 'rafamadriz/friendly-snippets',
    opts = {
        sources = {
            default = { "lsp", "buffer", "snippets", "path", },
            per_filetype = {
                sql = { 'snippets', 'buffer' },
                codecompanion = { "codecompanion" },
            },
        },
        appearance = {
            nerd_font_variant = 'normal'
        },
        keymap = { preset = 'super-tab' },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500
            },
            list = {
                max_items = 25,
            },
            menu = {
                draw = {
                    padding = { 0, 1 }, -- padding only on right side
                    components = {
                        kind_icon = {
                            text = function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' ' end
                        }
                    }
                }
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
            keymap = { preset = 'inherit' },
            completion = { menu = { auto_show = true } },
        },
    },
    config = function(_, opts)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local blink = require('blink.cmp')
        capabilities = blink.get_lsp_capabilities(capabilities)
        blink.setup(opts)
    end
}
