local M = {}

function M.list()
    local rows = {}
    local handle = io.popen(
        "zstd -dcf " ..
        vim.fn.expand("$HOME/.config/nvim/lua/utils/nerd_icons.csv.zst")
    )
    if handle then
        for line in handle:lines() do
            -- Pattern matching for 3 comma-separated columns
            local col1, col2, col3 = line:match("([^,]+),([^,]+),([^,]+)")
            if col1 and col2 and col3 then
                table.insert(rows, {
                    name = col1,
                    code = col2,
                    char = col3
                })
            end
        end
        handle:close()
    end
    return rows
end

return M
