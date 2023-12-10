return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = false,
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
