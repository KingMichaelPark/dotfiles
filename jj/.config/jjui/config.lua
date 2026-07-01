local function open_nvim()
    local file = context.file()
    if not file then
        return
    end
    exec_shell("nvim " .. file)
end

function setup(config)
    config.action(
        "[E]dit in nvim",
        open_nvim,
        { key = "e", scope = "revisions.details", desc = "Edit the file" }
    )
end
