return {
    "echasnovski/mini.trailspace",
    event = "BufWritePre",
    version = "*",
    config = function(_, opts) require("mini.trailspace").setup(opts) end,
}
