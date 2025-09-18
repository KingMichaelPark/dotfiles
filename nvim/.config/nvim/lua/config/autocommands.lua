local function augroup(name) return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true }) end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("filetype_detect"),
    pattern = { "Jenkinsfile" },
    callback = function() vim.cmd("set filetype=groovy") end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("terraform_detect"),
    pattern = { "*.tfvars" },
    callback = function() vim.cmd("set filetype=terraform") end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Trim trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function(_)
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Set SQL Comments
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("commentstring"),
    pattern = { "*.sql" },
    callback = function() vim.opt.commentstring = "-- %s" end,
    desc = "Change commentstring for SQL files",
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end


        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        if not client then
            return
        else
            if client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            end

            if client.name == 'ruff' then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
            end

            local default_cond = client:supports_method("textDocument/formatting") and client.name ~= "ts_ls"

            if default_cond then
                local group = augroup("LspFormatting")
                vim.api.nvim_clear_autocmds({ group = group, buffer = ev.buf })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = group,
                    buffer = ev.buf,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })
            end
        end
    end,
})
