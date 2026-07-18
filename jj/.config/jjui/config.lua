--- Prompt the user to ignore and untrack the currently active file.
local function ignore_file()
    local file = context.file()
    if not file then
        return
    end

    local confirm = choose({
        title = "Are you sure you want to ignore " .. file .. "?",
        options = { "Yes", "No" }
    })

    if confirm == "Yes" then
        -- Add the file to .gitignore if it doesn't exist
        exec_shell('rg --color never -Fxq "' .. file .. '" .gitignore 2>/dev/null || echo "' .. file .. '" >> .gitignore')
        revisions.details.refresh()

        -- Untrack the file in jj
        local _, err = jj("file", "untrack", file)
        if err then
            flash({ text = "Failed to untrack: " .. err, error = true })
        else
            revisions.details.refresh()
        end
    end
end

--- Prompt the user and permanently delete the active file.
---
--- Retrieves the active file path, requests confirmation, and if confirmed,
--- removes the file from the filesystem and refreshes the revisions list.
local function abandon_file()
    local file = context.file()
    if not file then
        return
    end

    -- Ask for confirmation before removing
    local confirm = choose({
        title = "Are you sure you want to completely remove " .. file .. "?",
        options = { "Yes", "No" }
    })

    if confirm == "Yes" then
        exec_shell('rm "' .. file .. '"')
        revisions.details.refresh()
    end
end


local function open_nvim()
    local file = context.file()
    if not file then
        return
    end
    exec_shell("nvim " .. file)
end

local function open_pr()
    -- 1. Grab the change ID from the active context
    local change_id = context.change_id() or revisions.current()
    if not change_id then
        flash({ text = "No revision selected", error = true })
        return
    end

    -- 2. Extract the bookmark name on this change
    local bookmark_output, err = jj("bookmark", "list", "-r", change_id)
    if err or not bookmark_output or bookmark_output == "" then
        flash({ text = "No bookmark found on this change.", error = true })
        return
    end

    -- Split output safely
    local lines = split_lines(bookmark_output)
    if not lines or #lines == 0 then
        flash({ text = "No bookmark strings found.", error = true })
        return
    end

    -- Parse the first bookmark name safely
    local bookmark = lines[1]:match("^([%w_/%-]+)")
    if not bookmark then
        flash({ text = "Failed to parse bookmark name.", error = true })
        return
    end

    -- 3. Get the Git remote URL using 'jj remote list'
    -- This succeeds cleanly with exit code 0, avoiding the jjui Go runtime panic
    local remote_output, remote_err = jj("git", "remote", "list")
    if remote_err or not remote_output or remote_output == "" then
        flash({ text = "Could not retrieve git remotes via jj remote list.", error = true })
        return
    end

    -- 4. Parse "owner/repo" from the remote list output
    -- Matches both: 'origin git@github.com:owner/repo.git' and 'origin https://github.com/owner/repo'
    local owner, repo = remote_output:match("github%.com[:/]([^/]+)/([^%.%s%c/]+)")

    if not owner or not repo then
        flash({ text = "Could not parse GitHub owner/repo from remote list.", error = true })
        return
    end

    -- 5. Construct the Lazygit-style comparison URL
    local pr_url = string.format("https://github.com/%s/%s/compare/%s?expand=1", owner, repo, bookmark)

    -- 6. Fire it off directly to your default macOS browser
    flash("Opening default browser...")
    exec_shell(string.format("open '%s'", pr_url))
end

function setup(config)
    config.action(
        "edit in nvim",
        open_nvim,
        { key = "e", scope = "revisions.details", desc = "Edit the file" }
    )

    config.action(
        "open pr",
        open_pr,
        { key = "o", scope = "revisions", desc = "Open or create PR in browser (Lazygit style)" }
    )

    config.action(
        "abandon file",
        abandon_file,
        { key = "a", scope = "revisions.details", desc = "Abandon the current file" }
    )

    config.action(
        "ignore file",
        ignore_file,
        { key = "i", scope = "revisions.details", desc = "Ignore the current file" }
    )
end
