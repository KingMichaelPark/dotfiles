local gh = require("utils").gh

--- Prompts the user for a query and sends it to the CodeCompanion gemini command.
--- If the query is not empty, it executes the Neovim command 'CodeCompanion gemini <query>'.
local function prompt_codecompanion_gemini()
    vim.ui.input({ prompt = "Query: " }, function(input)
        if not input or input == "" then return end

        vim.cmd(string.format("CodeCompanion gemini %s", input))
    end)
end

vim.pack.add({ gh("nvim-lua/plenary.nvim") })
vim.pack.add({ { src = gh("nvim-treesitter/nvim-treesitter"), branch = "main" } })
vim.pack.add({ gh("KingMichaelPark/age.nvim") })
vim.pack.add({ gh("olimorris/codecompanion.nvim") })

local identity = vim.fn.expand("$HOME/.config/sops/age/keys.txt")
local gemini_key
if vim.fn.filereadable(identity) == 1 then
    local secret = vim.fn.expand("$HOME/.dotfiles/access.age.json")

    gemini_key = require("age").from_sops(secret)["GEMINI_API_KEY"]
    vim.fn.setenv("GEMINI_API_KEY", gemini_key)
end

require("codecompanion").setup({
    ignore_warnings = true,
    adapters = {
        acp = {
            omp = function()
                local helpers = require("codecompanion.adapters.acp.helpers")
                return {
                    name = "omp",
                    formatted_name = "Oh My Pi",
                    type = "acp",
                    roles = {
                        llm = "assistant",
                        user = "user",
                    },
                    opts = {
                        vision = true, -- agent advertises promptCapabilities.image
                    },
                    commands = {
                        default = { "omp", "acp" },
                    },
                    defaults = {
                        -- authMethods advertised by `omp acp`: uses local ~/.omp credentials
                        auth_method = "agent",
                        mcpServers = {}, -- omp loads its own MCP config
                        timeout = 20000, -- 20 seconds
                    },
                    parameters = {
                        protocolVersion = 1,
                        clientCapabilities = {
                            fs = { readTextFile = true, writeTextFile = true },
                        },
                        clientInfo = {
                            name = "CodeCompanion.nvim",
                            version = "1.0.0",
                        },
                    },
                    handlers = {
                        setup = function(self) return true end,
                        auth = function(self) return true end,
                        form_messages = function(self, messages, capabilities)
                            return helpers.form_messages(self, messages, capabilities)
                        end,
                        on_exit = function(self, code) end,
                    },
                }
            end,
        },
        http = {
            gemini = function()
                return require("codecompanion.adapters").extend("gemini", {
                    defaults = {
                        auth_method = "gemini-api-key",
                    },
                    env = {
                        api_key = "GEMINI_API_KEY",
                    },
                    schema = {
                        model = {
                            default = "gemini-flash-latest",
                        },
                    },
                })
            end,
        },
    },
    interactions = {
        chat = {
            adapter = "omp",
            keymaps = {
                -- ACP-only: pick a previous agent session and load it into this buffer
                acp_resume = {
                    modes = { n = "gz" },
                    description = "Resume an ACP session",
                    callback = function(chat)
                        return require("codecompanion.interactions.chat.slash_commands.keymaps").resume.callback(chat)
                    end,
                },
            },
        },
        inline = {
            adapter = "gemini",
        },
        cmd = {
            adapter = "gemini",
        },
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
            },
        },
    },
})

vim.keymap.set({ "v" }, "<leader>ai", prompt_codecompanion_gemini, { noremap = true, silent = true })
vim.keymap.set({ "n" }, "<leader>ai", prompt_codecompanion_gemini, { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

-- Fresh chat pinned to a specific adapter (visual mode sends the selection as context)
vim.keymap.set(
    { "n", "v" },
    "<leader>ao",
    "<cmd>CodeCompanionChat adapter=omp<cr>",
    { desc = "New omp (ACP) chat", noremap = true, silent = true }
)
vim.keymap.set(
    { "n", "v" },
    "<leader>ag",
    "<cmd>CodeCompanionChat adapter=gemini<cr>",
    { desc = "New Gemini chat", noremap = true, silent = true }
)

vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
vim.keymap.set(
    "v",
    "<leader>ad",
    function() require("codecompanion").prompt("add_docs") end,
    { desc = "Add docstrings", noremap = true, silent = true }
)
vim.keymap.set(
    "v",
    "<leader>at",
    function() require("codecompanion").prompt("add_tests") end,
    { desc = "Add tests", noremap = true, silent = true }
)

vim.cmd([[cab cc CodeCompanion]])
