local gh = require("utils").gh
vim.pack.add({ gh("nvim-treesitter/nvim-treesitter") })

local ts = require("nvim-treesitter")
local parsers = {
    "bash",
    "comment",
    "css",
    "diff",
    "dockerfile",
    "elixir",
    "git_config",
    "gitcommit",
    "gitignore",
    "groovy",
    "go",
    "heex",
    "hcl",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "rst",
    "rust",
    "scss",
    "ssh_config",
    "sql",
    "terraform",
    "typst",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

for _, parser in ipairs(parsers) do
    ts.install(parser)
end

-- Not every treesitter parser is the same as the filetype detected
-- So the patterns need to be registered more cleverly
local patterns = {}
for _, parser in ipairs(parsers) do
    local parser_patterns = vim.treesitter.language.get_filetypes(parser)
    for _, pp in pairs(parser_patterns) do
        table.insert(patterns, pp)
    end
end

vim.treesitter.language.register("groovy", "Jenkinsfile")
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"

vim.api.nvim_create_autocmd("FileType", {
    pattern = patterns,
    callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end
})
