local kind_icons = {
    Class = "󰠱",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",
    Copilot = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰇽",
    File = "󰈙",
    Folder = "󰉋",
    Function = "󰊕",
    Interface = "",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Operator = "󰆕",
    Property = "󰜢",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = "",
    TypeParameter = "󰅲",
    Unit = "",
    Value = "󰎠",
    Variable = "󰂡",
}

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        'hrsh7th/cmp-cmdline'
        -- "zbirenbaum/copilot-cmp",
    },
    event = "InsertEnter",
    opts = function()
        local cmp = require("cmp")
        -- require("copilot_cmp").setup()
        local defaults = require("cmp.config.default")()
        local luasnip = require("luasnip")
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        cmp.setup.cmdline('/', {
            completion = { completeopt = 'menu,menuone,noselect' },
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        cmp.setup.cmdline(':', {
            completion = { completeopt = 'menu,menuone,noselect' },
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })

        return {
            completion = {
                completeopt = "menu,menuone,noinsert",
                keyword_length = 3
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Tab>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_selected_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
                { name = "orgmode" }
            }),
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
            sorting = defaults.sorting,
            formatting = {
                fields = { "menu", "abbr", "kind" },
                format = function(entry, item)
                    item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)
                    local menu_icon = {
                        nvim_lsp = "󰅬 ",
                        luasnip = " ",
                        buffer = " ",
                        path = " ",
                        nvim_lua = " ",
                    }
                    item.menu = menu_icon[entry.source.name]
                    return item
                end
            }
        }
    end
}
