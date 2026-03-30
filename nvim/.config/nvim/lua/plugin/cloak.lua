local gh = require("utils").gh

vim.pack.add({ gh("laytan/cloak.nvim") })

require("cloak").setup({
    enabled = true,
    cloak_character = "*",
    highlight_group = "Comment",
    cloak_length = nil,
    try_all_patterns = true,
    patterns = {
        {
            file_pattern = { ".env*", ".mise.toml", "^config$", "^credentials$" },
            cloak_pattern = "=.+",
            replace = nil,
        },
    },
})

vim.keymap.set("n", "<leader>ct", "<cmd>:CloakToggle<cr>", { desc = "[c]loak [t]oggle" })
vim.keymap.set("n", "<leader>ce", "<cmd>:CloakEnable<cr>", { desc = "[c]loak [e]nable" })
vim.keymap.set("n", "<leader>cd", "<cmd>:CloakDisable<cr>", { desc = "[c]loak [d]isable" })
