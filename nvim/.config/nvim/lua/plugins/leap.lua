return {
    "ggandor/leap.nvim",
    event = "BufReadPre",
    config = function()
        require("leap").add_default_mappings()
        -- Exclude whitespace and the middle of alphabetic words from preview:
        --   foobar[baaz] = quux
        --   ^----^^^--^^-^-^--^
        require('leap').opts.preview_filter =
            function(ch0, ch1, ch2)
                return not (
                    ch1:match('%s') or
                    ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
                )
            end

        require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
        require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    end,
}
