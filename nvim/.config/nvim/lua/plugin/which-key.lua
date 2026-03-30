local gh = require("utils").gh
vim.pack.add({ gh("folke/which-key.nvim") })

require("which-key").setup({
    preset = "modern",
    icons = { rules = false },
})

vim.keymap.set(
    "n",
    "<leader>?",
    function() require("which-key").show({ global = false }) end,
    { desc = "Buffer Local Keymaps (which-key)" }
)
