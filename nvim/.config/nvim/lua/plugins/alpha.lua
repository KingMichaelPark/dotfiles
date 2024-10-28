local function split(word)
    local lines = {}
    for s in word:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end
    return lines
end

local splashes = {
    split(string.format([[
             ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
             ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
            ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
            ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██
            ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
            ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
            ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
               ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░
                     ░    ░  ░    ░ ░        ░   ░         ░
                                            ░                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]])),
}

-- Dashboard
local function alpha_options()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = splashes[1]
    dashboard.section.buttons.val = {
        dashboard.button("p", "  Plugins", ":Lazy<CR>"),
        dashboard.button("m", "  Mason", ":lua require('mason.ui').open()<CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
        dashboard.button("r", "󰈚  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "󰩈  Quit NVIM", ":qa<CR>"),
    }

    return dashboard
end

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("alpha").setup(alpha_options().config) end,
}
