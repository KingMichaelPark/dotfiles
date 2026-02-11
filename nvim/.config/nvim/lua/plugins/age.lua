return {
    "KingMichaelPark/age.nvim",
    keys = {
        {
            "<leader>E",
            function() require('age').encrypt() end,
            mode = { "v" },
            desc = "age [E]ncrypt the selected text",
        }
    }
}
