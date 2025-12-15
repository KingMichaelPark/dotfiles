--- Prompts the user for a query and sends it to the CodeCompanion gemini command.
--- If the query is not empty, it executes the Neovim command 'CodeCompanion gemini <query>'.
local function prompt_codecompanion_gemini()
    local query = vim.fn.input("Query: ")
    if query ~= "" then
        vim.cmd("CodeCompanion gemini " .. query)
    end
end


-- Reads the entire content of a file.
---
--- Attempts to open and read a file at the given path.
---
---@param path string The path to the file to read.
---@return string|nil The full content of the file as a string if successful,
---                    or `nil` if the file cannot be opened.
local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a"   -- *a or *all reads the whole file
    file:close()
    return content
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
                        })
                    end,
                },
            },
            strategies = {
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
                ["Add Docstrings"] = {
                    strategy = "inline",
                    description = "Add Docstrings",
                    opts = {
                        mapping = "<leader>ad",
                        modes = { "v" },
                        short_name = "add_docs",
                        is_slash_command = true,
                        auto_submit = true,
                        stop_context_insertion = true,
                        user_prompt = true,
                    },
                    prompts = {
                        {
                            role = "user",
                            content = function(context)
                                local text = require("codecompanion.helpers.actions").get_code(context.start_line,
                                    context.end_line)

                                local docstring_prompt = read_file(vim.fn.expand(
                                    "$HOME/.config/nvim/prompts/docstring.txt"))
                                return "I have the following code:\n\n```" ..
                                    context.filetype .. "\n" .. text .. "\n```\n\n" .. docstring_prompt
                            end,
                            opts = {
                                contains_code = true,
                            }
                        },
                    }
                },
                ["Generate Unit Tests"] = {
                    strategy = "chat",
                    description = "Create unit tests",
                    opts = {
                        mapping = "<leader>at",
                        modes = { "v" },
                        short_name = "add_tests",
                        is_slash_command = true,
                        auto_submit = true,
                        stop_context_insertion = true,
                        user_prompt = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = function(context)
                                local unit_test_prompt = read_file(vim.fn.expand(
                                    "$HOME/.config/nvim/prompts/unit-test.txt"))
                                return "I want you to act as a senior "
                                    .. context.filetype
                                    .. " developer specializing in testing. " .. unit_test_prompt
                            end,
                        },
                        {
                            role = "user",
                            content = function(context)
                                local text = require("codecompanion.helpers.actions").get_code(context.start_line,
                                    context.end_line)
                                return "I have the following code:\n\n```" ..
                                    context.filetype .. "\n" .. text .. "\n```\n\n"
                            end,
                            opts = {
                                contains_code = true,
                            }
                        },
                    }
                },
                ["Generate PRD"] = {
                    strategy = "chat",
                    description = "Create project requirements doc",
                    opts = {
                        mapping = "<leader>ar",
                        modes = { "v" },
                        short_name = "add_prd",
                        is_slash_command = true,
                        auto_submit = false,
                        stop_context_insertion = true,
                        user_prompt = true,
                    },
                    prompts = {
                        {
                            role = "user",
                            content = function(context)
                                local text = require("codecompanion.helpers.actions").get_code(context.start_line,
                                    context.end_line)

                                local prd = read_file(vim.fn.expand(
                                    "$HOME/.config/nvim/prompts/project-requirements-doc.txt"))
                                return prd .. "\n" .. text
                            end,
                            opts = {
                                contains_code = false,
                            }
                        },
                    },
                }
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
        vim.keymap.set("v", "<leader>ar", function() require("codecompanion").prompt("add_prd") end,
            { desc = "Add Project Requiremnts Doc", noremap = true, silent = true })

        vim.cmd([[cab cc CodeCompanion]])
    end
}
