return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }, { "<leader>lz", "<cmd>Lazy<cr>", desc = "Lazy" } },
    opts = {
        ensure_installed = {
            "biome",
            "ruff",
            "shfmt",
            "yamlfmt"
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
                p:install()
            end
        end
    end,
}
