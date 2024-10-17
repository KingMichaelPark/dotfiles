return {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    opts = {
        highlight = {
            use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = 'mono',


        trigger = { signature_help = { enabled = true } }
    }
}
