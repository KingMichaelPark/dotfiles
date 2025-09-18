return {
    "ThePrimeagen/harpoon",
    lazy = true,
    keys = {
        { "<leader>ma", '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = "Add File" },
        { "<leader>mm", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Menu" },
        { "<leader>m2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', desc = "Mark 2" },
        { "<leader>m1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', desc = "Mark 1" },
        { "<leader>m3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', desc = "Mark 3" },
        { "<leader>m4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', desc = "Mark 4" },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
}
