local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local smart_close = require("config.smart-close")

map("n", "<C-s>", "<cmd>w<cr>", { desc = "Write/Save" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<C-t>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })

map({ "v", "n" }, "<C-w>/", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map({ "v", "n" }, "<C-w>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true, noremap = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true, noremap = true })

-- Paste sensibily
map("v", "<leader>p", '"_dp', opts)
map("v", "<leader>P", '"_dP', opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Prime
map({ "n", "v" }, "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines down" })
map({ "n", "v" }, "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines up" })
map("n", "J", "mzJ`z", { desc = "Combine line below keep cursor" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank to system clipboard" })
map("n", "Q", "<nop>", { desc = "Unbind" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<C-l>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Location and QuickFix
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.get_next or vim.diagnostic.get_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        local diagnostics = vim.diagnostic.get(0, { severity = severity })
        if #diagnostics == 0 then
            local severity_word = severity and (severity == vim.diagnostic.severity.ERROR and "error" or "warning") or
                "diagnostic"
            vim.notify("No more " .. severity_word .. "s to jump to", vim.log.levels.INFO)
            return
        end
        go({ severity = severity })
    end
end
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

map("n", "<C-c>", smart_close.smart_buffer_close, { desc = "Smart close" })
