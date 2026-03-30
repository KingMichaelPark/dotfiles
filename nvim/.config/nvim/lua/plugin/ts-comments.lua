local gh = require("utils").gh
if vim.fn.has("nvim-0.10.0") == 1 then
    vim.pack.add({ gh("folke/ts-comments.nvim") })
    require("ts-comments").setup({ lang = { sql = "-- %s" } })
end
