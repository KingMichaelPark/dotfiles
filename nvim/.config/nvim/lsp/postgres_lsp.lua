return {
    cmd = { "postgrestools", "lsp-proxy" },
    filetypes = { 'sql' },
    root_markers = vim.fs.root(0, { 'postgrestools.jsonc' }),
    single_file_support = true,
}
