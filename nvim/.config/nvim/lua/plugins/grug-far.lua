return {
    'MagicDuck/grug-far.nvim',
    keys = {
        { "<leader>R", function() require('grug-far').open() end,                                                  desc = "Replace" },
        { "<leader>r", function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end,     desc = "Replace in File" },
        { "<leader>r", function() require('grug-far').open({ visualSelectionUsage = 'operate-within-range' }) end, mode = "v",              desc = "Replace Within" }
    },
    config = function()
        require('grug-far').setup({})
    end
}
