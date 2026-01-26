--- Prompts the user for a query and sends it to the CodeCompanion gemini command.
--- If the query is not empty, it executes the Neovim command 'CodeCompanion gemini <query>'.
local function prompt_codecompanion_gemini()
    local query = vim.fn.input("Query: ")
    if query ~= "" then
        vim.cmd("CodeCompanion gemini " .. query)
    end
end


return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-treesitter/nvim-treesitter", branch = "main" },
        { "KingMichaelPark/age.nvim",        lazy = true },
    },
    config = function()
        local identity = vim.fn.expand("$HOME/.config/sops/age/keys.txt")
        local gemini_key
        local anthropic_key
        if vim.fn.filereadable(identity) == 1 then
            local secret = vim.fn.expand("$HOME/.dotfiles/access.json")

            anthropic_key = require("age").from_sops(secret)["ANTHROPIC"]
            vim.fn.setenv("ANTHROPIC_API_KEY", anthropic_key)

            gemini_key = require("age").from_sops(secret)["GOOGLE"]
            vim.fn.setenv("GEMINI_API_KEY", gemini_key)
        end
        require("codecompanion").setup({
            ignore_warnings = true,
            adapters = {
                acp = {
                    gemini_cli = function()
                        return require("codecompanion.adapters").extend("gemini_cli", {
                            defaults = {
                                auth_method = "gemini-api-key",
                            },
                            env = {
                                api_key = "GEMINI_API_KEY",
                            },

                        })
                    end,
                },
                http = {
                    gemini = function()
                        return require("codecompanion.adapters").extend("gemini", {
                            defaults = {
                                auth_method = "gemini-api-key",
                            },
                            env = {
                                api_key = "GEMINI_API_KEY"
                            },
                            schema = {
                                model = {
                                    default = "gemini-3-flash-preview"
                                }
                            }
                        })
                    end,
                },
            },
            interactions = {
                chat = {
                    adapter = "gemini_cli",
                },
                inline = {
                    adapter = "gemini",
                },
                cmd = {
                    adapter = "gemini",
                }
            },
            display = {
                action_palette = {
                    provider = "fzf_lua",

                },
                diff = {
                    enabled = true,
                    close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
                    layout = "vertical", -- vertical|horizontal split for default provider
                    opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                },
            },
            prompt_library = {
                markdown = {
                    dirs = {
                        -- vim.fn.getcwd() .. "/.prompts", -- Can be relative
                        "~/.dotfiles/nvim/.config/nvim/prompts", -- Or absolute paths
                    }
                },
            },

        })

        vim.keymap.set({ "v" }, "<leader>ai", prompt_codecompanion_gemini, { noremap = true, silent = true, expr = true })
        vim.keymap.set({ "n" }, "<leader>ai", prompt_codecompanion_gemini, { noremap = true, silent = true })
        vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
        vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>",
            { noremap = true, silent = true })
        vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
        vim.keymap.set("v", "<leader>ad", function() require("codecompanion").prompt("add_docs") end,
            { desc = "Add docstrings", noremap = true, silent = true })
        vim.keymap.set("v", "<leader>at", function() require("codecompanion").prompt("add_tests") end,
            { desc = "Add tests", noremap = true, silent = true })

        vim.cmd([[cab cc CodeCompanion]])
    end
}
