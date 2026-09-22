local gh = require("utils").gh
vim.pack.add({ gh("nvim-lualine/lualine.nvim") })

local ok, p = pcall(require, "rose-pine.palette")
if not ok then
    p = {
        rose = "#ebbcba",
        foam = "#9ccfd8",
        iris = "#c4a7e7",
        love = "#eb6f92",
        pine = "#31748f",
        leaf = "#95b1ac",
        gold = "#f6c177",
        text = "#e0def4",
        subtle = "#908caa",
        muted = "#6e6a86",
    }
end

local mode_colors = {
    normal = p.rose,
    insert = p.foam,
    visual = p.iris,
    command = p.love,
    replace = p.pine,
    terminal = p.leaf,
    inactive = p.muted,
}

local custom = {}
for mode, color in pairs(mode_colors) do
    custom[mode] = {
        a = { fg = color, bg = "NONE", gui = "bold" },
        b = { fg = mode == "inactive" and p.muted or p.text, bg = "NONE" },
        c = { fg = mode == "inactive" and p.muted or p.subtle, bg = "NONE" },
        x = { fg = mode == "inactive" and p.muted or p.foam, bg = "NONE" },
        y = { fg = mode == "inactive" and p.muted or p.subtle, bg = "NONE" },
        z = { fg = mode == "inactive" and p.muted or p.iris, bg = "NONE" },
    }
end

local jj_cache = {}

local function update_jj_status()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].buftype ~= "" then return end

    -- 'jj log' with -n1 is faster and prevents the full diff output of 'jj show'
    -- local cmd = [[ jj log -r @ -n1 --no-graph -T "change_id.shortest() ++ ' ' ++ commit_id.shortest()" 2>/dev/null ]]
    local cmd = [[ jj log -r "closest_bookmark(@)" --no-graph -T 'bookmarks' --ignore-working-copy --quiet 2>/dev/null ]]

    local handle = io.popen(cmd)
    if handle then
        local result = handle:read("*a")
        handle:close()

        if result and result ~= "" then
            -- Remove newlines and extra spaces
            jj_cache[bufnr] = result:gsub("\n", ""):gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
        else
            jj_cache[bufnr] = ""
        end
    end
end

-- Refresh the info on relevant events
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    callback = update_jj_status,
})

-- The function for Lualine
local function get_jj_status()
    local bufnr = vim.api.nvim_get_current_buf()
    local status = jj_cache[bufnr] or ""
    return (status ~= "") and ("󱗆  " .. status) or ""
end

require("lualine").setup({
    options = {
        theme = custom,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { { "filename", path = 1 } },
        lualine_c = {},
        lualine_x = {
            {
                get_jj_status,
                color = { fg = p.foam, gui = "" },
            },
        },
        lualine_y = { "diff" },
        lualine_z = { "diagnostics" },
    },
})

-- Prevent rose-pine from making the statusline teal when a terminal/floating window is open
local function set_transparent_term_statusline()
    vim.api.nvim_set_hl(0, "StatusLineTerm", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineTermNC", { bg = "NONE", fg = "NONE" })
end

set_transparent_term_statusline()
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_transparent_term_statusline,
})
