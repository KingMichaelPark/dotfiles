return {
    'MagicDuck/grug-far.nvim',
    config = function()
        require('grug-far').setup({});

        vim.keymap.set("n", "<leader>R", function() require('grug-far').open() end, { desc = "Replace" })
        vim.keymap.set("n", "<leader>r",
            function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end,
            { desc = "Replace" })
        vim.keymap.set("v", "<leader>r", function()
            require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })
        end, { desc = "Replacer Within" })
    end
}
