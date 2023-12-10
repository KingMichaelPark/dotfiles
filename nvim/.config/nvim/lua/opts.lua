vim.api.nvim_set_option("spell", false)
vim.api.nvim_set_option("hidden", true)

vim.g.background = "dark"
vim.g.catppuccin_flavour = "mocha"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
vim.g.dashboard_default_executive = "telescope"
vim.g.gitblame_date_format = "%r"
vim.g.gitblame_enabled = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.pastetoggle = "<F2>"      -- Paste mode
vim.g.shiftround = true         -- Round indent
vim.g.splitright = true         -- Put new windows right of current
vim.g.updatetime = 200          -- Delay before swap file is saved
vim.g.wildmode = "list:longest" -- Command-line completion mode

vim.opt.backup = false
vim.opt.ch = 1
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.cursorline = true  -- Highlight cursor line
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.hidden = true
vim.opt.ignorecase = true  -- Ignore case
vim.opt.joinspaces = false -- No double spaces with join
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { leadmultispace = "│   ", space = ' ', tab = '  ' }
vim.opt.ls = 3
vim.opt.mouse = "a"
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 8         -- Lines of context
vim.opt.shiftwidth = 4        -- Size of an indent
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.sidescrolloff = 8     -- Columns of context
vim.opt.signcolumn = "yes"    -- Show sign column
vim.opt.smartcase = true      -- Don't ignore case with capitals
vim.opt.smartindent = true    -- Insert indents automatically
vim.opt.smd = false
vim.opt.softtabstop = 4
vim.opt.swapfile = false     -- Life life on the edge babyyyy
vim.opt.tabstop = 4          -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
vim.opt.wrap = false -- Disable line wrap
