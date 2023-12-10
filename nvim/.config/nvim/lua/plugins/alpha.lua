local function split(word)
    local lines = {}
    for s in word:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end
    return lines
end

local splashes = {
    split(
        [[
⣿⣿⢯⡻⣿⣿⢹⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣶⣿
⣿⣿⡏⡗⢝⣿⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡿
⣿⣿⣿⡰⠈⠻⠀⠀⠀⠀⠀⠀⣠⢀⣠⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⠋⠁⣴
⣿⣿⣿⣧⠃⠀⠀⠀⠀⣔⣤⣾⣿⡿⢿⣿⣿⣍⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣿
⣿⣿⣿⣿⡎⢀⣤⣶⣾⣿⣿⡿⣫⣾⠷⣾⣽⣿⣍⠀⠀⠀⠀⠀⠀⠀⠀⠘⣡⣿
⣿⣿⣿⣿⣷⡸⣿⣿⣿⣿⣟⣼⢫⡞⡄⠀⢻⣿⣷⣄⠀⣠⢤⢄⠀⠀⠀⡰⢟⣿
⣿⣿⣿⣿⣿⢸⡗⡚⢻⣿⣿⣿⡼⣧⢀⣀⢠⣿⣿⣿⣷⡷⣮⢿⠀⠀⠀⣠⣽⣿
⣿⣿⣿⣿⣿⣯⠓⡗⠀⣿⣿⣿⣿⣿⣷⣷⣿⣿⣿⣿⣿⠧⢟⡼⠀⣠⣾⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣧⢿⡀⣼⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡿⡘⠋⣠⣾⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⠫⠑⠈⡩⢸⣿⣿⣿⣿⡿⣱⣧⠸⣟⠛⣻⠕⣛⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣞⡿⣿⣷⣄⢾⣿⢹⣿⣿⡿⠫⣚⠭⢒⣩⡷⠛⡑⣾⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣯⣟⡷⣶⣿⠟⢋⡴⠊⣠⡴⠟⠁⠀⠈⠁⠼⢟⣫⣥
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣢⣶⣶⣶⣶⣶⣶⣤⣤⣌⣡⣾⡿⢟⣫
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⣠⡄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠸⣫⣾⣿⡿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣛⡵⠚⠋⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢻⠟⣋⣴
]])
}

-- Dashboard
local function alpha_options()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = splashes[1]
    dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Git File Search", [[<cmd>Telescope git_files<CR>]]),
        dashboard.button("r", "󱐋  RipGrep", [[<cmd>Telescope live_grep<CR>]]),
        dashboard.button("s", "  Settings", ":cd ~/.config/nvim | e init.lua <CR>"),
        dashboard.button("p", "  Plugins", ":Lazy<CR>"),
        dashboard.button("m", "  Mason", ":lua require('mason.ui').open()<CR>"),
        dashboard.button("q", "󰩈  Quit NVIM", ":qa<CR>"),
    }

    return dashboard
end

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("alpha").setup(alpha_options().config)
    end,
}
