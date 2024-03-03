return {
    'kristijanhusak/vim-dadbod-ui',
    event = "VeryLazy",
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
        -- $DBUI_URL is the environment variable for the connection string
        -- or to use DB_UI_<connection_name>
    end
}
