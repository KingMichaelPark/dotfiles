local unfixable = {
    "F401", -- https://docs.astral.sh/ruff/rules/unused-import/
    "F841", -- https://docs.astral.sh/ruff/rules/unused-variable/
}

return {
    settings = {
        init_options = {
            settings = {
                args = {
                    "--unfixable",
                    table.concat(unfixable, ",")
                },
            },
        },
    },
}
