local M = {}

-- Store revisions in memory to track changes during a session
local session_revs = {}

--- List all managed packages in a scratch buffer
function M.list(opts)
    opts = opts or {}
    local buf_name = "PackList"
    local current_buf = vim.api.nvim_get_current_buf()
    local current_buf_name = vim.api.nvim_buf_get_name(current_buf)

    -- If the current buffer is PackList, close it (unless we are refreshing)
    if not opts.refresh and current_buf_name:match(buf_name .. "$") then
        local wins = vim.api.nvim_list_wins()
        if #wins > 1 then
            vim.api.nvim_win_close(0, true)
        else
            vim.cmd("bdelete")
        end
        return
    end

    -- Check if PackList buffer already exists
    local target_buf = -1
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(buf):match(buf_name .. "$") then
            target_buf = buf
            break
        end
    end

    if target_buf ~= -1 then
        -- Check if it's visible in any window
        local win_found = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == target_buf then
                vim.api.nvim_set_current_win(win)
                win_found = true
                break
            end
        end
        if not win_found then
            vim.api.nvim_set_current_buf(target_buf)
        end
    else
        target_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(target_buf, buf_name)
        vim.api.nvim_set_current_buf(target_buf)

        -- Set buffer-local keymaps
        vim.keymap.set("n", "U", M.update, { buffer = target_buf, desc = "Update all plugins" })
        vim.keymap.set("n", "q", function()
            local wins = vim.api.nvim_list_wins()
            if #wins > 1 then
                vim.api.nvim_win_close(0, true)
            else
                vim.cmd("bdelete")
            end
        end, { buffer = target_buf, desc = "Close PackList" })
    end

    -- Refresh content
    local installed = vim.pack.get()
    local lines = { "# Managed Plugins", "", "(Press 'U' to update, 'q' to close)", "" }

    -- Sort by name for readability
    table.sort(installed, function(a, b) return a.spec.name < b.spec.name end)

    for _, p in ipairs(installed) do
        local status = p.active and "" or " "
        local rev_str = ""
        local updated_indicator = ""

        if p.rev then
            local short_rev = p.rev:sub(1, 7)

            -- Check if we have a previous revision stored for this plugin
            if session_revs[p.spec.name] and session_revs[p.spec.name] ~= p.rev then
                updated_indicator = " _Updated!_"
            end

            -- Update the session revision store
            session_revs[p.spec.name] = p.rev

            rev_str = string.format(" %s%s", short_rev, updated_indicator)
        end

        -- • Name [✓]  hash Δ
        table.insert(lines, string.format("- %s [%s] %s", p.spec.name, status, rev_str))
    end

    vim.api.nvim_set_option_value('modifiable', true, { buf = target_buf })
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = target_buf })
    vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value('modifiable', false, { buf = target_buf })
end

--- Fetch updates for all plugins
function M.update()
    print("Updating plugins...")
    vim.pack.update(nil, { force = true })
    M.list({ refresh = true })
end

--- Remove plugins that are installed on disk but not active in the current session
function M.clean()
    local installed = vim.pack.get()
    local to_delete = {}

    for _, p in ipairs(installed) do
        if not p.active then
            table.insert(to_delete, p.spec.name)
        end
    end

    if #to_delete > 0 then
        local prompt = "Delete " .. #to_delete .. " orphaned plugins?"
        vim.ui.select({ "Yes", "No" }, {
            prompt = prompt,
            format_item = function(item)
                if item == "Yes" then
                    return "Yes (Delete: " .. table.concat(to_delete, ", ") .. ")"
                end
                return item
            end
        }, function(choice)
            if choice == "Yes" then
                vim.pack.del(to_delete)
                print("Successfully removed orphaned plugins.")
            end
        end)
    else
        print("No orphaned plugins found.")
    end
end

return M
