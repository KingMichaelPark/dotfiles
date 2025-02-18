local unit_test_prompt = [[
A good unit test suite should aim to:
- Test the function's behavior for a wide range of possible inputs
- Test edge cases that the author may not have foreseen
- Take advantage of the features of `pytest` to make the tests easy to write and maintain
- Be easy to read and understand, with clean code and descriptive names
- Be deterministic, so that the tests always pass or fail in the same way

You are a world-class Python developer with an eagle eye for
unintended bugs and edge cases.
You write careful, accurate unit tests.
When asked to reply only with code, you write all of your code
in a single block.

If using Python and the `pytest` package if a generic test,
if there are references to django, write them for the django test
suite. Write a at least one, but up to a suite of unit tests for
the function, following the cases above. Include helpful comments
to explain each line. Reply only with code
]]

local docstring_prompt = [[
A good docstring should:
- Be concise and clear, avoiding unnecessary verbosity
- Follow Google style docstring format for Python code
- Include a brief one-line summary of what the function/class does
- List all parameters with their types and descriptions under Args:
- Document return values with types under Returns:
- Document any exceptions that may be raised under Raises:
- Avoid including examples or implementation details
- Use imperative mood ("Get" not "Gets")
- Focus on WHAT the code does, not HOW it does it
- Include type hints that match the function signature
- Document any side effects or important notes
- Be properly indented and formatted for readability

Write a concise, clear docstring following these guidelines.
Use Google style for Python code. Reply with the selected text
unchanged and the docstring added.
]]

return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "KingMichaelPark/age.nvim", lazy = true }
    },
    config = function()
        local identity = vim.fn.expand("$HOME/.config/sops/age/keys.txt")
        local gemini_key
        local anthropic_key
        if vim.fn.filereadable(identity) == 1 then
            local secret = vim.fn.expand("$HOME/.dotfiles/access.json")
            anthropic_key = require("age").from_sops(secret)["ANTHROPIC"]
            gemini_key = require("age").from_sops(secret)["GOOGLE"]
        end
        require("codecompanion").setup({
            adapters = {
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        env = {
                            api_key = gemini_key,
                            -- model = "gemini-2.0-flash-lite-preview-02-05",
                            model = "gemini-2.0-flash-001",
                        },
                    })
                end,
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic ", {
                        env = {
                            api_key = anthropic_key,
                        },
                    })
                end,
            },
            prompt_library = {
                ["Code Expert"] = {
                    strategy = "chat",
                    description = "Get some special advice from an LLM",
                    opts = {
                        mapping = "<LocalLeader>ah",
                        modes = { "v" },
                        short_name = "expert",
                        auto_submit = true,
                        stop_context_insertion = true,
                        user_prompt = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = function(context)
                                return "I want you to act as a senior "
                                    .. context.filetype
                                    .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
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
                    },
                },
                ["Add Docstrings"] = {
                    strategy = "inline",
                    description = "Get some special advice from an LLM",
                    opts = {
                        mapping = "<leader>ad",
                        modes = { "v" },
                        short_name = "add_docstrings",
                        is_slash_command = true,
                        auto_submit = true,
                        stop_context_insertion = true,
                        user_prompt = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = function(context)
                                return "I want you to act as a senior "
                                    .. context.filetype
                                    .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
                            end,
                        },
                        {
                            role = "user",
                            content = function(context)
                                local text = require("codecompanion.helpers.actions").get_code(context.start_line,
                                    context.end_line)

                                return "I have the following code:\n\n```" ..
                                    context.filetype .. "\n" .. text .. "\n```\n\n" .. docstring_prompt
                            end,
                            opts = {
                                contains_code = true,
                            }
                        },
                    },
                },
            },
            strategies = {
                chat = {
                    adapter = "gemini",
                },
                inline = {
                    adapter = "gemini",
                },
            },
        })
        vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
        vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>",
            { noremap = true, silent = true })
        vim.keymap.set({ "v" }, "<leader>ae", "<cmd>CodeCompanion /explain<cr>",
            { noremap = true, silent = true })
        vim.keymap.set({ "v" }, "<leader>ad", "<cmd>CodeCompanion /add_docstrings<cr>",
            { noremap = true, silent = true })
        vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

        vim.cmd([[cab cc CodeCompanion]])
    end
}
