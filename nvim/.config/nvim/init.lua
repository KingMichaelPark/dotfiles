-- Mike's Neovim Config


require("config.opts")
require("config.keymaps")
require("config.autocommands")
require("config.lazy-setup")
local lsps = require("config.get_lsps")
vim.lsp.enable(lsps)
