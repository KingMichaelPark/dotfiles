---
name: using-git-worktrees
description: Use when starting feature work that needs isolation from current workspace or before executing implementation plans - sets up a jj bookmark with one described change per task, and a jj workspace only when work must run in parallel
---

# Using jj Changes and Workspaces

## Overview

Your human partner uses Jujutsu (jj), not plain git. In jj, isolation comes from **changes**, not directories. A new change off the trunk bookmark cannot disturb any other work, so most work needs no extra directory.

**Core principle:** Work sequentially in the current workspace. Each task is one described change, stacked on the one before. One bookmark follows the stack, so your human partner can follow the work and squash it later. Create a jj workspace only when two things must run at the same time.

**REQUIRED:** Use the jj skill for all VCS commands. Always pass `--no-pager` and `-m`. Never push. Never use `git` commands to change state in a jj repo.

**Announce at start:** "I'm using the using-git-worktrees skill to set up a jj bookmark for this work."

## Step 0: Detect the Repo and Workspace

```bash
jj root                              # Fails → not a jj repo
jj --no-pager workspace list         # All workspaces and their @
jj workspace root                    # Root of the workspace you are in
jj --no-pager st                     # State of @
jj --no-pager log -r 'trunk()' --no-graph -T 'change_id.short() ++ " " ++ bookmarks ++ "\n"'
```

**Name the base explicitly.** Call it `<base>` from here on: the trunk bookmark (`main`, `master`, `trunk`) or the change the plan names. If `trunk()` prints the root change (`zzzzzzzz…`) with no bookmark, the repo has no remote trunk. Then `trunk()` is the root commit, and revsets like `trunk()..@` cover the whole history. Use the local bookmark instead. Then check for work already above the base:

```bash
jj --no-pager log -r '<base>..@'
```

**If `jj root` fails:** This is not a jj repo. Ask: "This repo has no `.jj`. Shall I run `jj git init --colocate`, or work in place with git?" Do not create a git worktree.

**If you are in a workspace other than `default`:** It already gives isolation. Do not create another one. Report: "Already in jj workspace `<name>` at `<path>`." Go to Step 1 and start the stack there.

**If `<base>..@` holds changes that are not part of this task:** Ask where to start: "There is work above `<base>` (`<change-ids>`). Shall I start on `<base>`, or stack on top of `<change-id>`?" Starting on `<base>` leaves that work untouched as a sibling. Nothing is lost either way.

### Harness worktree tools

Do NOT use `EnterWorktree`, `WorktreeCreate`, a `/worktree` command or `git worktree add` in a jj repo. They make a git worktree that jj does not know about. Its commits do not appear in `jj log` and do not join the bookmark. Use only if your human partner configured that tool for jj.

## Step 1: Start the Bookmark (default: sequential)

### Choose the bookmark

1. Use a bookmark name from your instructions, the plan, or the conversation.
2. Otherwise derive one from the plan, e.g. `feat/<topic>`, and state it in your report.
3. Check that it is not in use: `jj --no-pager bookmark list <name>`. If it exists, ask before you reuse it.

**Never move `<base>`, `main`, `master` or any trunk bookmark.** Bookmarks do not move by themselves, so this only happens when you move one. Only superpowers:finishing-a-development-branch moves the base, and only when your human partner picks that option.

### Create the first change

```bash
jj new <base> -m "<type>: <first task>"
jj bookmark create <name> -r @
```

If @ is already empty and has no description on the correct base, use `jj desc -m "<type>: <first task>"` instead of `jj new`.

### The per-task loop

Each task in the plan is one change. Describe it before you write code.

```bash
# 1. Start the task (skip `jj new` for the first task — Step 1 made it)
jj new -m "<type>: <task summary>"

# 2. Do the work. jj snapshots files automatically. No add, no commit.
jj --no-pager st

# 3. Finish the task: seal it, then move the bookmark onto it
jj new
jj bookmark move <name> --to @-
```

After step 3:
- `@` is an empty change on top of the stack, ready for the next task.
- The bookmark points at the last finished change.
- In a colocated repo, git `HEAD` is `@-`, the finished change. The helper scripts (`task-start`, `task-done`, `review-package`) read git `HEAD`, so always seal a task with `jj new` before you run them. The BASE for the next task is that same `@-`.

**Fix to an earlier task?** Make a new described change, e.g. `fix: <what>`, at the top of the stack. Do not `jj edit` or squash into earlier changes unless your human partner asks. They decide when to squash.

Your human partner follows the work with:

```bash
jj --no-pager log -r '<base>..<name>'
```

## Step 1b: Parallel Work in a jj Workspace (only when needed)

Create a workspace only when work must run at the same time in separate files on disk:
- Parallel agents that edit files concurrently (superpowers:dispatching-parallel-agents).
- A long build or test run that must continue while you edit.
- Your human partner asks for one.

Sequential tasks from a plan do NOT need a workspace. If you are unsure, work sequentially.

### Create it

Put workspaces next to the repo, not inside it. jj warns about workspaces inside the repo, and their files would show up in the main working copy.

```bash
repo=$(jj workspace root)
ws=<short-name>
jj workspace add --name "$ws" -r <name> -m "<type>: <parallel task>" "$repo/../$(basename "$repo")-$ws"
cd "$repo/../$(basename "$repo")-$ws"
```

`-r <name>` bases the new workspace on the bookmark tip. Each workspace has its own `@`, shown as `<ws>@` in `jj log`. In a colocated repo, jj also creates a matching git worktree, so the git-based helper scripts work there too.

**Sandbox fallback:** If `jj workspace add` fails with a permission error, tell your human partner the sandbox blocked the sibling directory. Then do the work sequentially in the current workspace.

### Rules while workspaces exist

- Never `jj edit` a change that is another workspace's `@`. It is the main cause of divergent changes (`xyz??` in `jj log`).
- Never rewrite (squash, rebase, abandon) a change that another workspace has as `@` while that workspace is in use.
- If jj reports "The working copy is stale", run `jj workspace update-stale` in that workspace, then `jj --no-pager st`.
- Each workspace has its own ignored files. Dependencies (`node_modules`, `target/`, `.venv`) are not shared. Run Step 2 in each new workspace.

### Bring the work back to the bookmark

The goal is still one linear stack under one bookmark. When a parallel task is finished and sealed with `jj new`:

```bash
jj --no-pager log -r '<name>..<ws>@'            # The workspace's changes
jj rebase -s <first-change-id> -d <name>        # Put them on the bookmark tip
jj bookmark move <name> --to <last-change-id>
jj --no-pager log -r '<base>..<name>'           # Confirm one linear stack
```

Repeat for each workspace, one at a time. If the rebase makes conflicts, edit the files to resolve them (not `jj resolve`), then check with `jj --no-pager st`.

### Remove it

Run these from the `default` workspace, not from the workspace you remove.

```bash
jj --no-pager -R "$(jj workspace root --name <ws>)" st   # Confirm nothing unexpected is left
jj workspace remove <ws>                        # Snapshots @, then deletes the directory
```

`jj workspace remove` keeps tracked files, but ignored files in that directory are lost. If the workspace holds ignored files that exist nowhere else (notes, plans, ledgers), show them to your human partner and ask before you remove it. Never `rm -rf` a workspace directory without `jj workspace forget <ws>`.

## Step 2: Project Setup

Auto-detect and run appropriate setup:

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

In the current workspace, dependencies are usually installed already. In a new jj workspace, they never are.

## Step 3: Verify Clean Baseline

Run tests to ensure the base starts clean:

```bash
# Use project-appropriate command
npm test / cargo test / pytest / go test ./...
```

**If tests fail:** Report failures, ask whether to proceed or investigate.

**If tests pass:** Report ready.

### Report

```
Bookmark <name> at <change-id>, based on <trunk/base>
Working in <workspace-name> at <full-path>
Tests passing (<N> tests, 0 failures)
Ready to implement <feature-name> — one described change per task
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| Not a jj repo | Ask: `jj git init --colocate` or work in place |
| `trunk()` is the root change | No remote trunk: use the local bookmark as `<base>` |
| Already in a non-default workspace | Do not create another; start the stack here |
| Unrelated work above `<base>` | Ask: start on `<base>` or stack on it |
| Normal plan execution | Sequential: one bookmark, one described change per task |
| Start a task | `jj new -m "<type>: <task>"` (or `jj desc -m` on empty @) |
| Finish a task | `jj new` then `jj bookmark move <name> --to @-` |
| Fix to earlier work | New `fix:` change at the top; do not squash |
| Truly parallel work | `jj workspace add --name <ws> -r <name> ../<repo>-<ws>` |
| Harness worktree tool offered | Do not use it in a jj repo |
| "Working copy is stale" | `jj workspace update-stale` |
| Parallel work done | Rebase onto bookmark, move bookmark, `jj workspace remove` |
| Permission error on workspace add | Work sequentially in place |
| Tests fail during baseline | Report failures + ask |

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Isolation means a new directory" | In jj, a new change off `<base>` is isolation. A directory is only for work that runs at the same time. |
| "`EnterWorktree` is the native tool, so I should use it" | It makes a git worktree that jj cannot see. Its work never joins the bookmark. |
| "I'll describe the change when the task is done" | Describe first. Your human partner follows the stack by its descriptions while you work. |
| "One big change is simpler" | One change per task. Your human partner squashes when they choose; they cannot easily split. |
| "I'll squash this fix into the earlier change" | Add a new `fix:` change. Rewriting history is your human partner's call. |
| "The bookmark will follow my work" | jj bookmarks never move by themselves. Move it after every task. |
| "`trunk()` is always the base" | With no remote, `trunk()` is the root commit. Name the base bookmark. |
| "I'll put the workspace in `.worktrees/`" | Workspaces go next to the repo, not inside it. |
| "The workspace is fresh — baseline tests can wait" | A dirty baseline makes every later failure ambiguous. Run the tests now; proceeding past failures is your human partner's call. |
