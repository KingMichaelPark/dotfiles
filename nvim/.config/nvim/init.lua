-- Mike's Neovim Config:

-- This should compartmentalise and allow for only what modules
-- you wish to be used, to be used
require("opts")
require("mappings")
require("autocommands")
require("init-plugins")
require("lazy").setup("plugins")
