return {
    'stevearc/conform.nvim',
    opts = {},
    event = { "BufNewFile", "BufWritePre" },
    lazy = true,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = { "ruff_format", "ruffer" },
                javascript = { "biome" },
                typescript = { "biome" },
                json = { "biome" },
                jsonc = { "biome" },
                jsx = { "biome" },
                css = { "biome" },
                scss = { "biome" },
                sql = { "sqlfluff" },
                shell = { "shfmt" },
                terraform = { "terraform_fmt" },
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
            formatters = {
                ruffer = {
                    command = "ruff",
                    args = {
                        "--fix",
                        "-e",
                        "--unfixable",
                        "F401,F841",
                        "--extend-select",
                        "ARG,B,C4,DTZ,I,S,UP",
                        "--stdin-filename",
                        "$FILENAME",
                        "-",
                    },
                    stdin = true,
                    cwd = require("conform.util").root_file({
                        "pyproject.toml",
                        "ruff.toml",
                    }),
                }
            }

        })
    end
}
