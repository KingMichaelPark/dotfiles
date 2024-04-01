return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-refactor" },
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
        require("treesitter-context").setup {
            max_lines = 1,
            line_numbers = false
        }
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "comment",
                "css",
                "csv",
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
                "jsonc",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "org",
                "python",
                "r",
                "regex",
                "rst",
                "rust",
                "scss",
                "ssh_config",
                "sql",
                "terraform",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn", -- set to `false` to disable one of the mappings
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            indent = {
                enable = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                refactor = {
                    smart_rename = {
                        enable = true,
                        -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                        keymaps = {
                            smart_rename = "grr",
                        },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                },
            },
        })
        vim.treesitter.language.register('groovy', 'Jenkinsfile') -- the someft filetype will use the python parser and queries.
    end,
}
