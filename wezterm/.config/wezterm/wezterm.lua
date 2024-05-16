local wezterm = require("wezterm")

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#181825"
custom.cursor_bg = "#cdd6f4"

local tmux = { "/opt/homebrew/bin/tmux", "new", "-As", "main" }

return {
    color_schemes = {
        ["Mikeppuccin"] = custom,
    },
    color_scheme = "Mikeppuccin",
    default_prog = tmux,
    window_background_opacity = 0.95,
    macos_window_background_blur = 40,
    font = wezterm.font({ family = "Mikevka Nerd Font" }),
    send_composed_key_when_left_alt_is_pressed = true, -- MacOS Fix
    font_size = 18,
    hide_tab_bar_if_only_one_tab = true,
    initial_cols = 180,
    initial_rows = 45,
    line_height = 1.2,
    warn_about_missing_glyphs = false,
    window_close_confirmation = 'NeverPrompt',
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    window_padding = {
        top = "1.5cell",
    }
}
