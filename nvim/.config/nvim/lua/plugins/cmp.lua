return {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    opts = {
        keymap = {
            show = '<C-space>',
            hide = '<C-e>',
            accept = '<Tab>',
            select_prev = { '<Up>', '<C-p>' },
            select_next = { '<Down>', '<C-n>' },

            show_documentation = {},
            hide_documentation = {},
            scroll_documentation_up = '<C-b>',
            scroll_documentation_down = '<C-f>',

            snippet_forward = '<Tab>',
            snippet_backward = '<S-Tab>',
        },
        highlight = {
            use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = 'mono',
        accept = { auto_brackets = { enabled = true } },
        trigger = { signature_help = { enabled = true } }
    }
}
