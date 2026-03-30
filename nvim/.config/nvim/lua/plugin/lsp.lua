local gh = require("utils").gh
vim.pack.add({ gh("KingMichaelPark/mason.nvim") })
vim.pack.add({ gh("mason-org/mason-lspconfig.nvim") })
vim.pack.add({ gh("neovim/nvim-lspconfig") })

require("mason").setup({
    pip = {
        use_uv = true,
    },
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ruff" },
})
vim.keymap.set("n", "<leader>P", ":Mason<CR>", { desc = "Open Mason", noremap = true, silent = true })
