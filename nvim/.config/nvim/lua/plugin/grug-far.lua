local gh = require("utils").gh
vim.pack.add({ gh("MagicDuck/grug-far.nvim") })

require("grug-far").setup({})

vim.keymap.set("n", "<leader>R", function() require("grug-far").open() end, { desc = "Replace" })
vim.keymap.set(
    "n",
    "<leader>r",
    function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,
    { desc = "Replace in File" }
)
vim.keymap.set(
    "v",
    "<leader>r",
    function() require("grug-far").open({ visualSelectionUsage = "operate-within-range" }) end,
    { desc = "Replace Within" }
)
