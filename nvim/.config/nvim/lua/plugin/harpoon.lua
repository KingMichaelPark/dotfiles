local gh = require("utils").gh
vim.pack.add({ gh("nvim-lua/plenary.nvim") })
vim.pack.add({ gh("ThePrimeagen/harpoon") })

vim.keymap.set("n", "<leader>ma", '<cmd>lua require("harpoon.mark").add_file()<cr>', { desc = "Add File" })
vim.keymap.set("n", "<leader>mm", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { desc = "Menu" })
vim.keymap.set("n", "<leader>m2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', { desc = "Mark 2" })
vim.keymap.set("n", "<leader>m1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', { desc = "Mark 1" })
vim.keymap.set("n", "<leader>m3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', { desc = "Mark 3" })
vim.keymap.set("n", "<leader>m4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', { desc = "Mark 4" })
