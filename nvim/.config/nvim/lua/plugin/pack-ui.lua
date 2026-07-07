local gh = require("utils").gh
vim.pack.add({ gh("jtprogru/pack-ui.nvim") })

vim.keymap.set(
    "n",
    "<leader>ps",
    "<cmd>PackStatus<CR>",
    { desc = "PackStatus: Read-only overview, no network" }
)

vim.keymap.set(
    "n",
    "<leader>pu",
    "<cmd>PackUpdate<CR>",
    { desc = "PackUpdate: Open the window and update one by one" }
)

vim.keymap.set(
    "n",
    "<leader>pU",
    "<cmd>PackUpdateAll<CR>",
    { desc = "PackUpdateAll: Update All" }
)
