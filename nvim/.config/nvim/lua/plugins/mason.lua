return {
    "KingMichaelPark/mason.nvim",
    build = ":MasonUpdate",
    lazy = true,
    priority = 1000,
    opts = {
        pip = {
            use_uv = true,
        },
        ensure_installed = {
            "shfmt",
            "yamllint",
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then p:install() end
        end
    end,
}
