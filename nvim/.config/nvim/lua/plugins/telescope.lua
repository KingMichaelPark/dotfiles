return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            lazy=true,
        },
        {'nvim-telescope/telescope-ui-select.nvim', lazy=true}

    },
    keys = {
        { "<leader>/",  '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = "Buffer search", },
        { "<leader>fb", '<cmd>Telescope buffers<cr>',                   desc = "Buffers", },
        { "<leader>fc", '<cmd>Telescope git_commits<cr>',               desc = "Commits", },
        { "<leader>ff", '<cmd>Telescope find_files<cr>',                desc = "Find All Files", },
        { "<C-p>",      '<cmd>Telescope git_files<cr>',                 desc = "Git files", },
        { "<leader>fh", '<cmd>Telescope help_tags<cr>',                 desc = "Help", },
        { "<leader>fj", '<cmd>Telescope command_history<cr>',           desc = "History", },
        { "<leader>fk", '<cmd>Telescope keymaps<cr>',                   desc = "Keymaps", },
        { "<leader>fl", '<cmd>Telescope lsp_references<cr>',            desc = "Lsp References", },
        { "<leader>fo", '<cmd>Telescope oldfiles<cr>',                  desc = "Old files", },
        { "<leader>fr", '<cmd>Telescope live_grep<cr>',                 desc = "Ripgrep", },
        { "<leader>fs", '<cmd>Telescope grep_string<cr>',               desc = "Grep String", },
        { "<leader>ft", '<cmd>Telescope treesitter<cr>',                desc = "Treesitter", },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                layout_strategy = 'flex',
                layout_config = { height = 0.9, prompt_position = 'bottom', width = .9 },
                prompt_prefix = "▶",
                selection_caret = "▸",
                mappings = {
                    i = {
                        ["<esc>"] = require('telescope.actions').close
                    }
                },
            },
            pickers = {
                live_grep = {
                    additional_args = { "--hidden" },
                    glob_pattern = { "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock,**/.venv/*}" },
                    path_display = { "filename_first" },
                },
                find_files = {
                    file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                    hidden = true,
                    path_display = { "filename_first" },
                },
                git_files = {
                    path_display = { "filename_first" },
                }
            },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown {} }
            }
        })
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
}
