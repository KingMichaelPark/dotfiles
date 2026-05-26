-- Convert schema.table_name or prefix_table to {{ ref('table_name') }}
local function dbt_ref_replace()
    local mode = vim.api.nvim_get_mode().mode
    local start_row, start_col, end_row, end_col
    local text

    if mode:match("[vV]") then
        -- Keys to exit visual mode and update marks
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "x", true)
        local _, srow, scol, _ = unpack(vim.fn.getpos("'<"))
        local _, erow, ecol, _ = unpack(vim.fn.getpos("'>"))
        start_row, start_col = srow - 1, scol - 1
        end_row, end_col = erow - 1, ecol

        -- Handle visual line selection
        if mode == "V" then
            end_col = #vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1]
        end

        text = table.concat(vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {}), "\n")
    else
        -- Normal mode: auto-detect schema.table under cursor
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1

        -- Expand to grab table/schema characters (word characters, dots, and underscores)
        local start_idx, end_idx = col, col
        while start_idx > 1 and line:sub(start_idx - 1, start_idx - 1):match("[%w_%.]") do
            start_idx = start_idx - 1
        end
        while end_idx <= #line and line:sub(end_idx, end_idx):match("[%w_%.]") do
            end_idx = end_idx + 1
        end

        text = line:sub(start_idx, end_idx - 1)
        start_row = vim.api.nvim_win_get_cursor(0)[1] - 1
        start_col = start_idx - 1
        end_row = start_row
        end_col = end_idx - 1
    end

    if not text or text == "" then return end

    -- Extract the table name (everything after the last dot)
    local table_name = text:match("[^%.]+$") or text

    -- Clean up any surrounding quotes
    table_name = table_name:gsub("^['\"`]", ""):gsub("['\"`]$", "")

    local replacement = string.format("{{ ref('%s') }}", table_name)
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { replacement })
end

-- Keymap: <leader>dr in normal and visual modes
vim.keymap.set({ "n", "v" }, "<leader>dr", dbt_ref_replace, { desc = "Convert schema.table to dbt ref" })
