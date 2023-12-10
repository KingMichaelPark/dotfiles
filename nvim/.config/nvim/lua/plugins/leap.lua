return {
    "ggandor/leap.nvim",
    event = "BufReadPre",
    config = function()
        require("leap").add_default_mappings()
    end,
}
