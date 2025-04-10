return {
    'MagicDuck/grug-far.nvim',
    keys = {
        {
            "<leader>r",
            '<cmd>GrugFar<cr>',
            desc = "Replace",
        },
        {
            "<leader>R",
            '<cmd>GrugFarWithin<cr>',
            desc = "Replace Within",
        },

    },
    config = function()
        require('grug-far').setup({
            -- options, see Configuration section below
            -- there are no required options atm
            -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
            -- be specified
        });
    end
}
