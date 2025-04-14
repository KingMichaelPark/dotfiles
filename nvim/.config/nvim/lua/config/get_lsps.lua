local function get_filename(path)
    -- Find the last occurrence of the path separator.
    local separator = package.config:sub(1, 1) -- Get OS specific path separator
    local pos = string.find(path, separator, nil, true)
    local last_pos = pos
    while pos do
        last_pos = pos
        pos = string.find(path, separator, pos + 1, true)
    end

    if last_pos then
        return path:sub(last_pos + 1)
    else
        -- If no separator is found, the whole path is the filename.
        return path
    end
end


local function get_lua_filenames_without_extension()
    local filenames = vim.fn.glob(vim.fn.stdpath("config") .. "/lsp/*.lua")
    local filename_table = vim.split(filenames, "\n")
    local result = {}
    for _, path in ipairs(filename_table) do
        local fn = get_filename(path)
        if fn:match("init%.lua$") then
            goto continue
        end
        local name = vim.fn.fnamemodify(fn, ":r")
        table.insert(result, name)
        ::continue::
    end
    return result
end

-- LSP Settings
vim.diagnostic.config({
    -- virtual_lines = {
    --     -- Only show virtual line diagnostics for the current cursor line
    --     current_line = true,
    -- },
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = "󰗖 ",
            [vim.diagnostic.severity.HINT] = "󰘥 ",
            [vim.diagnostic.severity.INFO] = "󰋽 "
        }
    }
})

local lsps = get_lua_filenames_without_extension()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend('force', capabilities, {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
})

vim.lsp.config('*', {
    root_markers = { '.git' },
    capabilities = capabilities
})

for _, lsp in ipairs(lsps) do
    vim.lsp.enable(lsp)
end

return lsps
