local gh = require("utils").gh
vim.pack.add({ gh("KingMichaelPark/mason.nvim") })
vim.pack.add({ gh("mason-org/mason-lspconfig.nvim") })
vim.pack.add({ gh("neovim/nvim-lspconfig") })

require("mason").setup({
    pip = {
        use_uv = true,
    },
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ruff" },
})
vim.keymap.set("n", "<leader>M", ":Mason<CR>", { desc = "Open Mason", noremap = true, silent = true })

-- Nvim 0.12 ships a builtin `:lsp enable|disable|restart|stop`, and because it
-- exists nvim-lspconfig bails before creating any `Lsp*` command of its own
-- (see its plugin/lspconfig.lua). What is still missing is a buffer-scoped view
-- of what is actually running, so `:LspInfo` provides one.

local function open_float(title, lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].bufhidden = "wipe"

    local width = math.min(100, math.floor(vim.o.columns * 0.8))
    local height = math.min(#lines, math.floor(vim.o.lines * 0.8))
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = "minimal",
        border = "rounded",
        title = title,
        title_pos = "center",
    })
    vim.wo[win].wrap = true
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, nowait = true, desc = "Close" })
    vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, nowait = true, desc = "Close" })
end

local function client_state(client)
    if client:is_stopped() then
        return "stopped"
    end
    return client.initialized and "running" or "starting"
end

local function show_client_details(client)
    local cmd = client.config.cmd
    local lines = {
        string.format("# %s  (id %d, %s)", client.name, client.id, client_state(client)),
        "",
        "- root_dir: " .. (client.root_dir and vim.fn.fnamemodify(client.root_dir, ":~") or "-"),
        "- cmd: " .. (type(cmd) == "table" and table.concat(cmd, " ") or "<lua function>"),
        "- filetypes: " .. table.concat(client.config.filetypes or { "*" }, ", "),
    }

    local buffers = {}
    for bufnr in pairs(client.attached_buffers) do
        if vim.api.nvim_buf_is_valid(bufnr) then
            local name = vim.api.nvim_buf_get_name(bufnr)
            table.insert(buffers, name ~= "" and vim.fn.fnamemodify(name, ":~:.") or ("[No Name] " .. bufnr))
        end
    end
    table.sort(buffers)
    table.insert(lines, "")
    table.insert(lines, string.format("## Attached buffers (%d)", #buffers))
    for _, name in ipairs(buffers) do
        table.insert(lines, "- " .. name)
    end

    local capabilities = {}
    for name, value in pairs(client.server_capabilities or {}) do
        if value then
            table.insert(capabilities, name)
        end
    end
    table.sort(capabilities)
    table.insert(lines, "")
    table.insert(lines, string.format("## Server capabilities (%d)", #capabilities))
    for _, name in ipairs(capabilities) do
        table.insert(lines, "- " .. name)
    end

    open_float(string.format(" %s ", client.name), lines)
end

local function lsp_info()
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    if vim.tbl_isempty(clients) then
        vim.notify("No LSP clients attached to this buffer", vim.log.levels.WARN)
        return
    end

    local by_id, entries = {}, {}
    for _, client in ipairs(clients) do
        by_id[client.id] = client
        table.insert(
            entries,
            string.format(
                "%-4d %-18s %-8s %s",
                client.id,
                client.name,
                client_state(client),
                client.root_dir and vim.fn.fnamemodify(client.root_dir, ":~") or "-"
            )
        )
    end

    require("fzf-lua").fzf_exec(entries, {
        prompt = "  ",
        winopts = {
            height = 0.40,
            width = 0.80,
            title = string.format(" LSP clients (%d) ", #entries),
        },
        actions = {
            ["default"] = function(selected)
                local id = selected[1] and tonumber(selected[1]:match("^(%d+)"))
                local client = id and by_id[id]
                if client then
                    vim.schedule(function()
                        show_client_details(client)
                    end)
                end
            end,
        },
    })
end

vim.api.nvim_create_user_command("LspInfo", lsp_info, {
    desc = "List LSP clients attached to the current buffer",
})
