local wezterm = require("wezterm")
local config = wezterm.config_builder()
local colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

local sessioniser = require("sessioniser")

colors.background = "#131313"

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    -- splitting
    { mods = "LEADER", key = "-",          action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "/",          action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "LeftArrow",  action = wezterm.action.ActivatePaneDirection("Left") },
    { mods = "LEADER", key = "h",          action = wezterm.action.ActivatePaneDirection("Left") },
    { mods = "LEADER", key = "RightArrow", action = wezterm.action.ActivatePaneDirection("Right") },
    { mods = "LEADER", key = "l",          action = wezterm.action.ActivatePaneDirection("Right") },
    { mods = "LEADER", key = "UpArrow",    action = wezterm.action.ActivatePaneDirection("Up") },
    { mods = "LEADER", key = "k",          action = wezterm.action.ActivatePaneDirection("Up") },
    { mods = "LEADER", key = "DownArrow",  action = wezterm.action.ActivatePaneDirection("Down") },
    { mods = "LEADER", key = "j",          action = wezterm.action.ActivatePaneDirection("Down") },
    { mods = "LEADER", key = "p",          action = wezterm.action.ActivateTabRelative(-1) },
    { mods = "LEADER", key = "n",          action = wezterm.action.ActivateTabRelative(1) },
    { mods = "LEADER", key = "x",          action = wezterm.action.CloseCurrentPane({ confirm = false }) },
    { mods = "LEADER", key = "X",          action = wezterm.action.CloseCurrentTab({ confirm = false }) },
    { mods = "LEADER", key = "C",          action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { mods = "LEADER", key = "s",          action = wezterm.action_callback(sessioniser.search) },
    { mods = "LEADER", key = "p",          action = wezterm.action_callback(sessioniser.list) },
    { mods = "LEADER", key = "]",          action = wezterm.action.SwitchWorkspaceRelative(1) },
    { mods = "LEADER", key = "[",          action = wezterm.action.SwitchWorkspaceRelative(-1) },
    {
        mods = "LEADER",
        key = "!",
        action = wezterm.action_callback(function(_, pane)
            local _, _ = pane:move_to_new_tab()
        end),
    },
}

for i = 1, 9 do
    -- ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

config.use_fancy_tab_bar = false
config.font = wezterm.font({ family = "Mikevka Nerd Font" })
config.font_size = 18
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 180
config.initial_rows = 45
config.color_schemes = {
    ["Mikeppuccin"] = colors,
}
config.color_scheme = "Mikeppuccin"
config.macos_window_background_blur = 50
config.send_composed_key_when_left_alt_is_pressed = true -- MacOS Fix
config.warn_about_missing_glyphs = false
config.window_background_opacity = 0.95
config.line_height = 1.1
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
    top = "1.5cell",
}

return config
