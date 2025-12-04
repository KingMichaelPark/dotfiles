return {
    "sindrets/diffview.nvim",
    keys = {
        {
            "<leader>do",
            "<cmd>DiffviewOpen<cr>",
            desc = "DiffViewOpen",
        },
        {
            "<leader>dc",
            "<cmd>tabclose<cr>",
            desc = "DiffViewClose",
        },
        {
            "<leader>de",
            "<cmd>DiffviewToggleFiles<cr>",
            desc = "DiffviewToggleFiles",
        },
        {
            "<leader>dr",
            "<cmd>DiffviewRefresh<cr>",
            desc = "Diffview Refresh",
        },
        {
            "<leader>dh",
            "<cmd>DiffviewFileHistory %<cr>",
            desc = "Diffview File History",
        },
        {
            "<leader>dH",
            "<cmd>DiffviewFileHistory<cr>",
            desc = "Diffview Entire File History",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    }
}
