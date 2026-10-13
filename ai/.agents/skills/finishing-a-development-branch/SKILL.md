---
name: finishing-a-development-branch
description: Use when implementation is complete, all tests pass, and you need to decide how to integrate the work
---

# Finishing a Development Branch

## Overview

Your human partner uses Jujutsu (jj). The work is a stack of described changes under one bookmark (see superpowers:using-git-worktrees). Your human partner pushes, and squashes when they choose. You prepare the stack and offer local options only.

**Core principle:** Verify tests → Detect the stack → Present options → Execute choice → Clean up.

**REQUIRED:** Use the jj skill for all VCS commands. Always pass `--no-pager` and `-m`. **Never push.** Never use `git` commands to change state in a jj repo.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## Step 1: Verify Tests

Run the project's full test suite (`npm test` / `cargo test` / `pytest` / `go test ./...`).

**If tests fail**, report the failures and stop — the menu comes after a green suite:

```
Tests failing (<N> failures). Must fix before completing:

[Show failures]
```

**If tests pass:** continue to Step 2.

## Step 2: Detect the Stack

```bash
jj workspace root                     # Capture now — Step 6 may run from elsewhere
jj --no-pager workspace list
jj --no-pager bookmark list
jj --no-pager st
```

Find the bookmark for this work: from the plan, the conversation, or the bookmark nearest `@`. If you cannot tell, ask.

Then check the stack. Use the base from Step 3 for `<base>`.

```bash
jj --no-pager log -r '<base>..<bookmark>'
jj --no-pager log -r 'conflicts() & <base>..<bookmark>'   # Must be empty
jj --no-pager log -r '(<base>..<bookmark>) & description(exact:"")'   # Must be empty
```

| Finding | Action |
|---------|--------|
| `@` has changes and is not on the bookmark | Finish it as a task: describe it, `jj new`, `jj bookmark move <bookmark> --to @-`. Ask first if you did not make those changes. |
| A change in the stack has conflicts | Resolve them by editing files, then re-run Step 1 |
| A change in the stack has no description | Describe it with `jj desc -r <change-id> -m "..."` |
| Divergent change (`xyz??` in `jj log`) | Stop and show your human partner |
| `@` is in a workspace other than `default` | Note the workspace for Step 6 |

## Step 3: Determine the Base

The base is the change the stack started from — usually named in the plan, the conversation, or as the trunk bookmark (`main`, `master`, `trunk`). Name it explicitly. Do not rely on `trunk()` alone:

```bash
jj --no-pager log -r 'trunk()' --no-graph -T 'change_id.short() ++ " " ++ bookmarks ++ "\n"'
```

If this prints the root change (`zzzzzzzz…`) with no bookmark, the repo has no remote trunk and `trunk()` is the root commit. Any revset like `trunk()..<bookmark>` then includes the whole history. Use the local bookmark (e.g. `main`) as `<base>` instead.

If the base is not already known, ask: "This stack starts from <your best guess> - is that correct?" Confirm before you rebase or squash: a wrong base is expensive to undo.

## Step 4: Present Options

**Present exactly these 4 options:**

```
Implementation complete on bookmark <bookmark> (<N> changes on <base>). What would you like to do?

1. Keep the stack as-is (you review, squash and push)
2. Rebase the stack onto the latest <base> and re-run tests
3. Squash the stack into one change on <bookmark>
4. Move <base> to <bookmark> locally (no push)

Which option?
```

Present the menu exactly as written — concise, with every option coming
from the list above. Discarding the work happens only in response to your
human partner explicitly asking for it (see "If your human partner asks to
discard the work" below). Wait for their answer; the integration decision
is theirs.

## Step 5: Execute Choice

### Option 1: Keep As-Is

Report:

```
Keeping bookmark <bookmark> at <change-id>: <N> changes on <base>.
Follow it with: jj --no-pager log -r '<base>..<bookmark>'
```

Offer once: "Shall I draft a PR title and description for when you push?" If yes, write them in your reply. Do not push or create the PR.

### Option 2: Rebase onto Latest Base

```bash
jj git fetch                       # Only if <base> tracks a remote; this does not push
jj rebase -b <bookmark> -d <base>
jj --no-pager st
jj --no-pager log -r 'conflicts() & <base>..<bookmark>'
```

Then run the full test suite on the rebased stack.

**If there are conflicts or tests fail:** stop and report. Nothing has been pushed. `jj undo` restores the stack as it was before the rebase. Ask before you fix or undo.

**If clean and green:** report the new base and change count. Keep the bookmark. Nothing to clean up.

### Option 3: Squash the Stack

Ask for the message if your human partner has not given one. Suggest one from the plan:

```
Squash <N> changes into one with message "<type>: <summary>"?
```

Then:

```bash
jj squash --from '<base>..<bookmark> ~ roots(<base>..<bookmark>)' \
          --into 'roots(<base>..<bookmark>)' -m "<message>"
jj --no-pager log -r '<base>::<bookmark>'     # One change on <base>, bookmark on it
jj --no-pager diff --stat -r <bookmark>
```

Run the full test suite on the squashed change. If the result looks wrong, `jj undo` restores the stack.

### Option 4: Move Base Locally

This is a local fast-forward. The bookmark for `<base>` moves; nothing is pushed.

```bash
jj --no-pager log -r '<base> & ::<bookmark>'   # Must print <base>; else rebase first (Option 2)
jj bookmark move <base> --to <bookmark>
jj --no-pager log -r '<base>'
```

If `<base>` is not an ancestor of `<bookmark>`, stop and offer Option 2 first. Never use `--allow-backwards`.

Run the full test suite. When it is green, ask before you delete the feature bookmark (`jj bookmark delete <bookmark>`). Then clean up (Step 6). Tell your human partner that `<base>` now differs from its remote and that pushing is theirs to do.

### If your human partner asks to discard the work

This path exists only as a response to an explicit request to throw the
work away. Confirm first:

```
This will abandon:
- Bookmark <bookmark>
- All changes: <change-list>
- Workspace <ws> at <path> (if any)

Type 'discard' to confirm.
```

Wait for that exact confirmation. When it arrives, clean up workspaces first (Step 6), then:

```bash
jj abandon '<base>..<bookmark>'        # Also deletes the bookmark
jj --no-pager bookmark list <bookmark> # Confirm it is gone
jj --no-pager st
```

Tell your human partner that `jj op log` and `jj undo` can still restore it.

## Step 6: Cleanup Workspaces

**Runs for Option 4 and confirmed discards.** Options 1, 2 and 3 keep everything in place — your human partner may iterate on the stack.

In the default sequential flow there is no extra workspace. If `jj --no-pager workspace list` shows only `default`, there is nothing to clean up. Done.

**If a workspace has a path next to the repo named `<repo>-<ws>`:** superpowers:using-git-worktrees created it — we own cleanup. Run from the `default` workspace:

```bash
cd "$(jj workspace root --name default)"
jj --no-pager -R "$(jj workspace root --name <ws>)" st   # Check what is left
jj --no-pager log -r '<ws>@'                             # Its @ must be empty or already on the bookmark
jj workspace remove <ws>
```

`jj workspace remove` snapshots tracked files into `<ws>@` before it deletes the directory. Ignored files in the directory are lost.

**If the workspace has unsaved work or ignored files that matter** (notes, plans, `.superpowers/` ledgers): never remove it on your own initiative. Show your human partner what is at stake and ask:

```
Workspace <ws> holds work that is not on <bookmark>:

<change or file list>

1. Rebase it onto <bookmark> before cleanup
2. Move the files into <default workspace root>
3. Remove it anyway (ignored files are unrecoverable)

Which?
```

Carry out the choice, then remove the workspace.

**Otherwise:** The host environment owns this workspace — leave it in place. If your platform provides a workspace-exit tool, use it.

## Quick Reference

| Option | Rewrites stack | Moves base | Push | Cleanup |
|--------|----------------|------------|------|---------|
| 1. Keep as-is | - | - | - | - |
| 2. Rebase onto base | yes (rebase) | - | - | - |
| 3. Squash | yes (squash) | - | - | - |
| 4. Move base locally | - | yes | - | yes |
| Discard (explicit request only) | yes (abandon) | - | - | yes |

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Tests passed earlier this session" | Run the suite on the stack you are about to integrate. A green run only proves the tree it ran on. |
| "They obviously want it squashed" | Squashing is your human partner's decision. Present the menu and wait. |
| "I'll just push it so the PR is ready" | Never push. Your human partner always pushes. Offer to draft the PR text instead. |
| "`trunk()` is the base" | Check it. With no remote, `trunk()` is the root commit and `trunk()..<bookmark>` is the whole history. |
| "They seem done with this feature — I'll offer to discard it" | The menu is complete as written. Discard happens only when your human partner asks for it in so many words. |
| "'Yeah, get rid of it' counts as confirmation" | Only the typed word `discard` authorizes abandoning the work. |
| "This other workspace looks stale — I'll remove it too" | Remove only `<repo>-<ws>` workspaces that superpowers created. Everything else belongs to the host. |
| "`rm -rf` the workspace directory is quicker" | Use `jj workspace remove`. A deleted directory without `forget` leaves a phantom workspace. |
| "The rebased-result failure is probably flaky" | A failing result stops everything. The stack stays put while you investigate. |
| "`<base>` is behind — `--allow-backwards` will fix it" | It never needs to go backwards in a fast-forward. Rebase first (Option 2). |
