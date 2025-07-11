return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "KingMichaelPark/mason.nvim" },
        { "mason-org/mason-lspconfig.nvim" }
    },
    priority = 1000,
    build = ":MasonUpdate",
    keys = {
        { "<leader>P", ":Mason<CR>", desc = "Open Mason" },
    },
    config = function()
        require("mason").setup({
            pip = {
                use_uv = true,
            },
        })
        require("mason-lspconfig").setup {
            ensure_installed = { "basedpyright", "ruff", "lua_ls" },
        }
    end
}
