return {
    'stevearc/conform.nvim',
    opts = {},
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
                shell = { "shfmt" },
                terraform = { "terraform_fmt" },
                -- yaml = { "yamlfmt" }
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
                        "-n",
                        "--target-version",
                        "py312",
                        "--unfixable",
                        "F401,F841",
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
