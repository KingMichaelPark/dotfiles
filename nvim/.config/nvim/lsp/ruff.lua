local selects = {
    "A",     -- https://docs.astral.sh/ruff/rules/#flake8-builtins-a
    "ANN",   -- https://docs.astral.sh/ruff/rules/#flake8-annotations-ann
    "ARG",   -- https://docs.astral.sh/ruff/rules/#flake8-unused-arguments-arg
    "ASYNC", -- https://docs.astral.sh/ruff/rules/#flake8-async-async
    "B",     -- https://docs.astral.sh/ruff/rules/#flake8-bugbear-b
    "C4",    -- https://docs.astral.sh/ruff/rules/#flake8-comprehensions-c4
    "D",     -- https://docs.astral.sh/ruff/rules/#pydocstyle-d
    "DJ",    -- https://docs.astral.sh/ruff/rules/#flake8-django-dj
    "DTZ",   -- https://docs.astral.sh/ruff/rules/#flake8-datetimez-dtz
    "E",     -- https://docs.astral.sh/ruff/rules/#error-e
    "F",     -- https://docs.astral.sh/ruff/rules/#pyflakes-f
    "G",     -- https://docs.astral.sh/ruff/rules/#flake8-logging-format-g
    "I",     -- https://docs.astral.sh/ruff/rules/#isort-i
    "N",     -- https://docs.astral.sh/ruff/rules/#pep8-naming-n
    "PERF",  -- https://docs.astral.sh/ruff/rules/#perflint-perf
    "PT",    -- https://docs.astral.sh/ruff/rules/#flake8-pytest-style-pt
    "PTH",   -- https://docs.astral.sh/ruff/rules/#flake8-use-pathlib-pth
    "Q",     -- https://docs.astral.sh/ruff/rules/#flake8-quotes-q
    "RET",   -- https://docs.astral.sh/ruff/rules/#flake8-return-ret
    "RUF",   -- https://docs.astral.sh/ruff/rules/#ruff-specific-rules-ruf
    "S",     -- https://docs.astral.sh/ruff/rules/#flake8-bandit-s
    "SIM",   -- https://docs.astral.sh/ruff/rules/#flake8-simplify-sim
    "UP",    -- https://docs.astral.sh/ruff/rules/#pyupgrade-up
    "W"      -- https://docs.astral.sh/ruff/rules/#warning-w

}
local unfixable = {
    "F401", -- https://docs.astral.sh/ruff/rules/unused-import/
    "F841", -- https://docs.astral.sh/ruff/rules/unused-variable/
}


return {
    settings = {
        init_options = {
            settings = {
                args = {
                    "--extend-select",
                    table.concat(selects, ","),
                    "--unfixable",
                    table.concat(unfixable, ",")
                },
            },
        },
    },
}
