return {
    "saghen/blink.cmp",
    version = "0.*",
    lazy = false,
    opts_extend = { "sources.default" },
    dependencies = 'rafamadriz/friendly-snippets',
    opts = {
        keymap = { preset = 'super-tab' },
        completion = {
            list = {
                max_items = 100,
            },
            menu = {
                draw = {
                    treesitter = { 'lsp' },
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                },
                trigger = {
                    show_on_insert_on_trigger_character = false,
                }
            },
            -- Displays a preview of the selected item on the current line
            ghost_text = {
                enabled = true,
            },
        },

        -- Experimental signature help support
        signature = {
            enabled = true,
        },
    }

}
