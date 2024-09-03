return {
    'mistweaverco/kulala.nvim',
    opts = {},
    keys = {
        { "<leader>kS", "<cmd>lua require('kulala').show_stats()<CR>",       desc = "Show last request stats" },
        { "<leader>k[", "<cmd>lua require('kulala').jump_prev()<CR>",        desc = "Jump to previous request" },
        { "<leader>k]", "<cmd>lua require('kulala').jump_next()<CR>",        desc = "Jump to next request" },
        { "<leader>ka", "<cmd>lua require('kulala').run_all()<CR>",          desc = "Run all requests" },
        { "<leader>kc", "<cmd>lua require('kulala').copy()<CR>",             desc = "Copy current request as cURL" },
        { "<leader>ke", "<cmd>lua require('kulala').set_selected_env()<CR>", desc = "Set selected environment" },
        { "<leader>kg", "<cmd>lua require('kulala').get_selected_env()<CR>", desc = "Get selected environment" },
        { "<leader>ki", "<cmd>lua require('kulala').inspect()<CR>",          desc = "Inspect current request" },
        { "<leader>kk", "<cmd>lua require('kulala').scratchpad()<CR>",       desc = "Open scratchpad" },
        { "<leader>kq", "<cmd>lua require('kulala').close()<CR>",            desc = "Close kulala window" },
        { "<leader>kr", "<cmd>lua require('kulala').replay()<CR>",           desc = "Replay last request" },
        { "<leader>kr", "<cmd>lua require('kulala').run()<CR>",              desc = "Run current request" },
        { "<leader>ks", "<cmd>lua require('kulala').search()<CR>",           desc = "Search .http and .rest files" },
        { "<leader>kt", "<cmd>lua require('kulala').toggle_view()<CR>",      desc = "Toggle view" },
    }
}
