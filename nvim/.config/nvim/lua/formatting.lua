vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

local on_attach = function(_, buf)
    vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bopts = { buffer = buf, noremap = true, silent = true, }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bopts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, bopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bopts)
    vim.keymap.set('n', '<space>p', function()
        vim.lsp.buf.format { async = true }
    end, bopts)
    -- end,
    -- })
end

return { on_attach = on_attach }
