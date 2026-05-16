local M = {}

M.instances = {}

local default_config = {
    cmd = "jjui",
    title = " Terminal ",
    footer = " Toggle with keymap ",
    width = 0.9,
    height = 0.9,
    keymap = "<A-j>",
}

local function create_float(instance_key)
    local inst = M.instances[instance_key]
    local width = math.floor(vim.o.columns * inst.config.width)
    local height = math.floor(vim.o.lines * inst.config.height)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    if not vim.api.nvim_buf_is_valid(inst.buf) then
        inst.buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
        title = inst.config.title,
        title_pos = "center",
        footer = inst.config.footer,
        footer_pos = "right",
    }

    inst.win = vim.api.nvim_open_win(inst.buf, true, win_config)
end

function M.toggle(instance_key)
    local inst = M.instances[instance_key]
    if not inst then return end

    if vim.api.nvim_win_is_valid(inst.win) then
        vim.api.nvim_win_close(inst.win, false)
        inst.win = -1
    else
        local is_new_buf = not vim.api.nvim_buf_is_valid(inst.buf)
        create_float(instance_key)

        if is_new_buf then
            vim.fn.jobstart({ inst.config.cmd }, {
                term = true,
                on_exit = function()
                    if vim.api.nvim_win_is_valid(inst.win) then
                        vim.api.nvim_win_close(inst.win, true)
                    end
                    if vim.api.nvim_buf_is_valid(inst.buf) then
                        vim.api.nvim_buf_delete(inst.buf, { force = true })
                    end
                    inst.win = -1
                    inst.buf = -1
                end
            })
        end
        vim.cmd("startinsert")
    end
end

function M.setup(opts)
    -- Ensure opts is a list of configurations
    local configs = (opts and opts[1]) and opts or { opts }

    for _, config in ipairs(configs) do
        local merged = vim.tbl_deep_extend("force", default_config, config or {})
        local instance_key = merged.cmd

        M.instances[instance_key] = {
            config = merged,
            buf = -1,
            win = -1,
        }

        local toggle_fn = function() M.toggle(instance_key) end

        vim.keymap.set("n", merged.keymap, toggle_fn, { desc = "Toggle " .. instance_key, noremap = true, silent = true })
        vim.keymap.set("t", merged.keymap, toggle_fn, { desc = "Toggle " .. instance_key, noremap = true, silent = true })
    end
end

return M
