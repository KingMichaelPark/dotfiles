return {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    enabled = true,
    config = function()
        require('cloak').setup({
            enabled = true,
            cloak_character = '*',
            highlight_group = 'Comment',
            cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
            try_all_patterns = true,
            patterns = {
                {
                    -- Match any file starting with '.env'.
                    -- This can be a table to match multiple file patterns.
                    file_pattern = { '.env*', '.mise.toml', '^config$', '^credentials$' },
                    cloak_pattern = { '=.+' },
                    replace = nil,
                },
            },
        })
    end
}
