local pm = require('config.pack_manager')

vim.api.nvim_create_user_command('PackList', pm.list, { desc = 'List all managed plugins' })
vim.api.nvim_create_user_command('PackUpdate', pm.update, { desc = 'Update all managed plugins' })
vim.api.nvim_create_user_command('PackClean', pm.clean, { desc = 'Remove unused plugins from disk' })
