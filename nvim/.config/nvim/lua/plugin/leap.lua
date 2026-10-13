local cb = require("utils").cb
vim.pack.add({ cb("andyg/leap.nvim") })

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")

require("leap").opts.preview_filter = function(ch0, ch1, ch2)
    return not (ch1:match("%s") or ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
end

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('LeapBackdrop', {}),
    callback = function()
        if vim.g.colors_name == 'rose-pine' then
            require('leap.user').set_backdrop_highlight('Leap')
        end
    end
})

require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
