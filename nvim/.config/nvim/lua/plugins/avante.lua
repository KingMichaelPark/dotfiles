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
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    build = "make",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        { "KingMichaelPark/age.nvim", lazy = true },
    },
    keys = {
        {
            "<leader>ad",
            function()
                require("avante.api").ask({
                    question = docstring_prompt,
                })
            end,
            mode = "v",
            desc = "Avante add docstrings",
        },
        {
            "<leader>at",
            function()
                require("avante.api").ask({
                    question = unit_test_prompt,
                })
            end,
            mode = "v",
            desc = "Avante add tests",
        },
    },
    config = function()
        local identity = vim.fn.expand("$HOME/.config/sops/age/keys.txt")
        if vim.fn.filereadable(identity) == 1 then
            local secret = vim.fn.expand("$HOME/.dotfiles/access.json")
            vim.env["ANTHROPIC_API_KEY"] = require("age").from_sops(secret)["ANTHROPIC"]
            require("avante").setup({
                provider = "claude",
                auto_suggestions_provider = "claude",
                hints = { enabled = true },
                file_selector = {
                    provider = "native",
                    provider_opts = {},
                }
            })
        end
    end
}
