local M = {}

-- Maintain the state of the buffer and window to allow toggling
-- without killing the terminal process.
local state = {
    buf = -1,
    win = -1,
}

local function create_float()
    -- Calculate dimensions for an 80% screen-size centered window
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Use the existing buffer, or create a new scratch buffer if it doesn't exist
    local buf = state.buf
    if not vim.api.nvim_buf_is_valid(buf) then
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- Utilizing Neovim 0.12 floating window features
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
        title = " jjui ",
        title_pos = "center",
        footer = " Toggle with keymap ",
        footer_pos = "right",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)
    return buf, win
end

function M.toggle()
    if vim.api.nvim_win_is_valid(state.win) then
        -- Hide the window, keeping the terminal buffer alive
        vim.api.nvim_win_close(state.win, false)
        state.win = -1
    else
        local is_new_buf = not vim.api.nvim_buf_is_valid(state.buf)

        state.buf, state.win = create_float()

        if is_new_buf then
            -- Run the interactive jjui command in a terminal buffer
            vim.fn.termopen("jjui", {
                on_exit = function(_, _, _)
                    -- Clean up the state when the jjui process exits
                    if vim.api.nvim_win_is_valid(state.win) then
                        vim.api.nvim_win_close(state.win, true)
                    end
                    if vim.api.nvim_buf_is_valid(state.buf) then
                        vim.api.nvim_buf_delete(state.buf, { force = true })
                    end
                    state.win = -1
                    state.buf = -1
                end
            })
        end

        -- Automatically enter insert mode when the terminal opens
        -- so you can start interacting with jjui immediately.
        vim.cmd("startinsert")
    end
end

function M.setup(opts)
    opts = opts or {}
    -- Alt/Option + j is often a good choice because it can be seamlessly
    -- mapped in both Normal and Terminal modes without requiring <C-\><C-n>
    local keymap = opts.keymap or "<A-j>"

    -- Normal mode toggle
    vim.keymap.set("n", keymap, M.toggle, { desc = "Toggle jjui floating terminal", noremap = true, silent = true })

    -- Terminal mode toggle (allows closing from within the active terminal)
    vim.keymap.set("t", keymap, M.toggle, { desc = "Toggle jjui floating terminal", noremap = true, silent = true })
end

return M

-- require("jjui").setup({
--   keymap = "<leader>j" -- Set to whichever keymap you prefer
-- })
