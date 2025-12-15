local g = vim.g
local opt = vim.opt

vim.api.nvim_command("set noshowcmd")
vim.api.nvim_command("set nofoldenable")

g.background = "dark"
g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
g.dashboard_default_executive = "telescope"
g.mapleader = " "
g.maplocalleader = " "
g.shiftround = true -- Round indent
g.splitright = true -- Put new windows right of current

opt.backup = false
opt.breakindent = true
opt.completeopt = { "menuone", "noinsert", "noselect" }
-- opt.conceallevel = 2
opt.cursorline = false         -- Highlight cursor line
opt.expandtab = true           -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hidden = true
opt.ignorecase = true    -- Ignore case
opt.inccommand = "split" -- preview incremental substitute
opt.joinspaces = false   -- No double spaces with join
opt.laststatus = 3
opt.lazyredraw = true
opt.list = true
opt.mouse = "a"
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4         -- Lines of context
opt.shiftwidth = 4        -- Size of an indent
opt.shortmess = vim.opt.shortmess + { c = true }
opt.showmode = false
opt.sidescrolloff = 8  -- Columns of context
opt.signcolumn = "yes" -- Show sign column
opt.smartcase = true   -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.smd = false
opt.smoothscroll = true
opt.softtabstop = 4
opt.spell = false
opt.splitbelow = true    -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true    -- Put new windows right of current
opt.swapfile = false     -- Life life on the edge babyyyy
opt.tabstop = 4          -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
opt.undofile = true
opt.updatetime = 200               -- Delay before swap file is saved
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.wrap = false                   -- Disable line wrap
