return {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = false,
    opts_extend = { "sources.default" },
    dependencies = 'rafamadriz/friendly-snippets',
    opts = {
        sources = {
            default = { "lsp", "path", "snippets", "buffer", },
            per_filetype = {
                sql = { 'snippets', 'buffer' },
                codecompanion = { "codecompanion" },
            },
        },
        keymap = { preset = 'super-tab' },
        completion = {
            -- documentation = { auto_show = true },
            list = {
                max_items = 100,
            },
            menu = {
                draw = {
                    treesitter = { 'lsp' },
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
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
    },
    config = function(_, opts)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local blink = require('blink.cmp')
        capabilities = blink.get_lsp_capabilities(capabilities)
        blink.setup(opts)
    end
}
