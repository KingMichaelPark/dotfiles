---
name: using-jj-workspaces
description: Use when starting feature work that needs isolation from current workspace or before executing implementation plans in a Jujutsu (jj) repository. Prefer plain jj non-workspace flows.
---

# Using Jujutsu (jj) Workspaces

## Overview

Ensure work happens in an isolated workspace using Jujutsu (jj) workspaces when specifically requested or required for parallel execution.

**Core principle:** Jujutsu's standard flow (using `jj new`, `jj edit`, and mutable commits) handles most concurrent development gracefully. Plain `jj` is highly preferred over creating workspaces. Only use workspaces if explicitly needed for parallel agent execution or sandboxing. Never use raw git commands in a jj repo.

**Announce at start:** "I'm using the using-jj-workspaces skill to manage our Jujutsu workspace."

## Step 0: Determine if Workspace is Needed

**Before creating anything, evaluate if plain `jj` is sufficient.**
Because Jujutsu makes it effortless to juggle concurrent features via standard commits (`jj new`, `jj rebase`, `jj edit`), a separate filesystem workspace is rarely needed. 

Has the user explicitly requested a separate workspace, parallel development, or an isolated sandbox?
- **If NO:** Work in place. Do not create a workspace. Use standard `jj` commands. Proceed to Step 2.
- **If YES:** Proceed to Step 1.

## Step 1: Create Isolated Workspace

If a workspace is genuinely needed for isolation, follow these steps.

### 1a. Prepare the Base Commit
Create a new commit before adding the workspace, so the new workspace shares a common parent rather than branching directly off your active working copy commit.

```bash
jj new
```

### 1b. Add the Workspace
Jujutsu workspaces must live as **siblings** to the main repository to avoid invalid nested repository states.

```bash
# Determine destination (sibling directory)
WORKSPACE_DIR="../feature-$BRANCH_NAME"

jj workspace add "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR"
```
*(Note: You can name the workspace explicitly with `--name`, but leaving it off defaults to the destination directory name.)*

## Step 2: Project Setup

Auto-detect and run appropriate setup in the working directory:

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

## Step 3: Verify Clean Baseline

Run tests to ensure workspace starts clean:

```bash
# Use project-appropriate command
npm test / cargo test / pytest / go test ./...
```

**If tests fail:** Report failures, ask whether to proceed or investigate.
**If tests pass:** Report ready.

## Interacting Between Workspaces

A major advantage of jj workspaces is that all changes in all workspaces are visible at once via `jj log`. You don't lose context.
- **Rebasing:** You can move commits among workspaces effortlessly (e.g., `jj rebase -s w -d m`).
- **Synchronizing:** If you rebase a commit on top of a default workspace’s commit, they share the common line. If you want to advance the default workspace to HEAD, just run `jj edit <revision>` from that workspace.
- **Resolving Conflicts:** Jujutsu's standard conflict handling applies when rebasing across workspaces.

## Cleanup

When the isolated workspace is no longer needed:

```bash
# In the main repository
jj workspace forget <workspace-name>
rm -r ../<workspace-name>
```

## Red Flags

**Never:**
- Default to workspaces for normal work. Plain `jj` is preferred.
- Create a jj workspace *inside* the main repo directory. Always make it a sibling (`../name`).
- Use `git worktree` commands when a `.jj/` directory exists.
- Surface standard git commands to the user when working with workspaces in a jj repo.
