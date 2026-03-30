local gh = require("utils").gh
vim.pack.add({ gh("echasnovski/mini.icons") })
vim.pack.add({ gh("stevearc/oil.nvim") })

require("mini.icons").setup({})
require("oil").setup({})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
