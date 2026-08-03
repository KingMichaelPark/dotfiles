local gh = require("utils").gh
vim.pack.add({ gh("jtprogru/pack-ui.nvim") })

vim.keymap.set(
    "n",
    "<leader>U",
    "<cmd>PackUpdate<CR>",
    { desc = "PackUpdate: Open the window and update one by one" }
)
