local opts = { noremap = true, silent = true }
local ks = vim.keymap.set

local utils = require("utils")
local l = utils.l
local o = utils.o

-- Buffers
ks("n", "<C-l>", "<cmd>bnext<cr>", o(opts, "Next buffer"))
ks("n", "<C-h>", "<cmd>bprevious<cr>", o(opts, "Previous Buffer"))
ks({ "v", "n" }, "<C-w>/", "<cmd>vsplit<cr>", o(opts, "Split vertical"))
ks({ "v", "n" }, "<C-w>-", "<cmd>split<cr>", o(opts, "Split horizontal"))

-- Paste sensibily
ks("v", l("p"), '"_dp', opts)
ks("v", l("P"), '"_dP', opts)
ks("v", "<", "<gv", opts)
ks("v", ">", ">gv", opts)

-- Prime
ks("v", "J", ":m '>+1<CR>gv=gv", o(opts, "Move highlighted lines down"))
ks("v", "K", ":m '<-2<CR>gv=gv", o(opts, "Move highlighted lines up"))
ks("n", "J", "mzJ`z", o(opts, "Combine line below keep cursor"))
ks({ "n", "v" }, l("y"), '"+y', o(opts, "Yank to system clipboard"))
ks("n", l("Y"), '"+Y', o(opts, "Yank to system clipboard"))
ks("n", "Q", "<nop>", o(opts, "Unbind"))
ks("n", "<A-h>", "<cmd>cprev<CR>zz", o(opts, "Quickfix CPrevious"))
ks("n", "<A-l>", "<cmd>cnext<CR>zz", o(opts, "Quickfix CNext"))
ks("n", "<A-j>", "<cmd>lprev<CR>zz", o(opts, "LocList Previous"))
ks("n", "<A-k>", "<cmd>lnext<CR>zz", o(opts, "LocList Next"))
