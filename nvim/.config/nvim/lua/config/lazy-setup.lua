-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.fn.isdirectory(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    change_detection = { notify = false },
    spec = {
        { import = "plugins" },
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                -- "gzip",
                -- "matchit",
                -- "matchparen",
                "tarPlugin",
                "tohtml",
                "tutor",
                -- "zipPlugin",
            },
        },
    },
})

vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Open LazyVim" })
