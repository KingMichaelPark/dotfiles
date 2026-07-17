local gh = require("utils").gh
vim.pack.add({ gh("nvim-lua/plenary.nvim") })
vim.pack.add({ gh("kdheepak/lazygit.nvim") })

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>g/", "<cmd>LazyGitFilter<cr>", { desc = "LazyGit Filter" })
vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "LazyGit Current File Filter" })
