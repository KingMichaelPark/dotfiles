return {
    "saghen/blink.cmp",
    version = "0.*",
    opts_extend = { "sources.completion.enabled_providers" },
    event = "InsertEnter",
    dependencies = 'rafamadriz/friendly-snippets',
    opts = {
        keymap = {
            preset = "super-tab",
        },
        sources = {
            completion = {
                enabled_providers = { 'lsp', 'buffer', 'path', 'snippets' },
            },
        },
        windows = {
            autocomplete = {
                draw = {
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                },
            },
        },
    },
}
