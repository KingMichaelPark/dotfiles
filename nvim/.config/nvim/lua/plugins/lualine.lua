return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local custom = require("lualine.themes.catppuccin-mocha")
        local modes = { "insert", "normal", "command", "visual", "replace", "terminal", "inactive" }
        for _, mode in ipairs(modes) do
            custom[mode].a.bg = "NONE"
            custom[mode].b.bg = "NONE"
            if mode == "normal" or mode == "inactive" then
                custom[mode].c.bg = "NONE"
            end
            custom[mode].a.fg = custom[mode].a.bg
        end


        local jj_cache = {}

        local function update_jj_status()
            local bufnr = vim.api.nvim_get_current_buf()
            if vim.bo[bufnr].buftype ~= '' then return end

            -- 'jj log' with -n1 is faster and prevents the full diff output of 'jj show'
            local cmd =
            [[ jj log -r @ -n1 --no-graph -T "change_id.shortest() ++ ' ' ++ commit_id.shortest()" 2>/dev/null ]]

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
        vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'DirChanged' }, {
            callback = update_jj_status
        })

        -- The function for Lualine
        local function get_jj_status()
            local bufnr = vim.api.nvim_get_current_buf()
            local status = jj_cache[bufnr] or ""
            return (status ~= "") and ("󰠬 " .. status) or ""
        end

        -- Change the background of lualine_c section for normal mode
        require("lualine").setup({
            options = {
                theme = custom,
                component_separators = { left = "", right = "", },
                section_separators = { left = "", right = "" }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "filename", path = 1 } },
                lualine_c = {},
                lualine_x = {
                    {
                        get_jj_status,
                        color = { fg = "#89dceb", gui = "" }, -- Added custom color here (e.g., Catppuccin Peach)
                    },
                },
                lualine_y = { "diff" },
                lualine_z = { "diagnostics" },
            },
        })
    end,
}
