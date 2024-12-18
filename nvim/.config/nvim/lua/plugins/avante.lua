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
    lazy = true,
    version = false,
    keys = {
        {
            "<leader>ad",
            function()
                require("avante.api").ask({
                    question = [[
                    Add docstrings to this selected code.
                    If it is python code, use google style
                    docstrings with Args, Returns.
                    Don't include examples and don't ]],
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
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        { "stevearc/dressing.nvim",   lazy = true },
        { "MunifTanjim/nui.nvim",     lazy = true },
        { "KingMichaelPark/age.nvim", lazy = true },
    },
    config = function()
        local identity = vim.fn.expand("$HOME/.config/sops/age/keys.txt")
        if vim.fn.filereadable(identity) == 1 then
            local secret = vim.fn.expand("$HOME/.dotfiles/access.json")
            vim.env.ANTHROPIC_API_KEY = require("age").from_sops(secret)["ANTHROPIC"]

            require("avante").setup({
                provider = "claude",                  -- Recommend using Claude
                auto_suggestions_provider = "gemini", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
                claude = {
                    endpoint = "https://api.anthropic.com",
                    -- model = "claude-3-5-sonnet-20241022",
                    model = "claude-3-5-haiku-20241022",
                    temperature = 0,
                    max_tokens = 4096,
                },
                behaviour = {
                    auto_suggestions = false, -- Experimental stage
                    auto_set_highlight_group = true,
                    auto_set_keymaps = true,
                    auto_apply_diff_after_generation = false,
                    support_paste_from_clipboard = false,
                },
                hints = { enabled = false },
            })
        end
    end,
}
