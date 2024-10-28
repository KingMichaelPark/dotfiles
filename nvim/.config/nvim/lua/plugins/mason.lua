return {
    "KingMichaelPark/mason.nvim",
    build = ":MasonUpdate",
    keys = {
        { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
        { "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy" },
    },
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
