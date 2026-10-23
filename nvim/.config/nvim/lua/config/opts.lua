local g = vim.g
local o = vim.o

vim.api.nvim_command("set noshowcmd")
vim.api.nvim_command("set nofoldenable")

g.background = "dark"
g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
g.dashboard_default_executive = "telescope"
g.mapleader = " "
g.maplocalleader = " "
g.shiftround = true -- Round indent
g.splitright = true -- Put new windows right of current

o.backup = false
o.breakindent = true
o.completeopt = "menuone,noinsert,noselect"
-- o.conceallevel = 2
o.cursorline = false         -- Highlight cursor line
o.expandtab = true           -- Use spaces instead of tabs
o.formatoptions = "jcroqlnt" -- tcqj
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.hidden = true
o.ignorecase = true    -- Ignore case
o.inccommand = "split" -- preview incremental substitute
o.joinspaces = false   -- No double spaces with join
o.laststatus = 3
o.lazyredraw = true
o.list = true
o.mouse = "a"
o.number = true         -- Show line numbers
o.relativenumber = true -- Relative line numbers
o.scrolloff = 4         -- Lines of context
o.shiftwidth = 4        -- Size of an indent
vim.opt.shortmess:append("c")
o.showmode = false
o.sidescrolloff = 8  -- Columns of context
o.signcolumn = "yes" -- Show sign column
o.smartcase = true   -- Don't ignore case with capitals
o.smartindent = true -- Insert indents automatically
o.showcmd = false    -- `smd` is short for `showcmd`
o.smoothscroll = true
o.softtabstop = 4
o.spell = false
o.splitbelow = true    -- Put new windows below current
o.splitkeep = "screen"
o.splitright = true    -- Put new windows right of current
o.swapfile = false     -- Life life on the edge babyyyy
o.tabstop = 4          -- Number of spaces tabs count for
o.termguicolors = true -- True color support
o.timeoutlen = 200
o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
o.undofile = true
o.updatetime = 200               -- Delay before swap file is saved
o.wildmode = "longest:full,full" -- Command-line completion mode
o.wrap = false                   -- Disable line wrap
