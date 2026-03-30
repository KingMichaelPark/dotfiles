local gh = require("utils").gh

vim.pack.add({ gh("KingMichaelPark/age.nvim") })
vim.keymap.set(
    { "v" },
    "<leader>E",
    function() require("age").encrypt() end,
    { desc = "age [E]ncrypt the selected text" }
)
