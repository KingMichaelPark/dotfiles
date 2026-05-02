## CRITICAL: VCS IDENTITY & SAFETY
* **Detector:** If `.jj/` exists, this is a **Jujutsu** repository.
* **Protocol:** **NEVER** use raw `git` commands (e.g., `git commit`, `git add`). Direct Git interaction in a `jj` repo can lead to state desynchronization or data corruption.
* **Priority:** Always execute `jj` commands first for any VCS operation (status, commit, branch, push).

---

## AGENT OPERATIONAL RULES
To prevent terminal hangs and execution errors:
1.  **MANDATORY `-m` FLAGS:** Never run commands that open an editor (e.g., `jj desc`, `jj squash`). Always provide the message inline:
    * `jj desc -m "message"`
    * `jj new -m "message"`
2.  **NO INTERACTIVE UI:** Avoid `-i` flags (e.g., `jj squash -i` or `jj split`).
3.  **NON-INTERACTIVE CONFLICTS:** Do not use `jj resolve`. Edit conflict markers in files directly, then verify with `jj st`.
4.  **VERIFICATION:** Run `jj st` after any mutation (`squash`, `absorb`, `rebase`, `restore`) to confirm success.

---

## CORE CONCEPTS

### 1. The Working Copy (`@`)
The working directory is always a commit. There is **no staging area** and **no `jj commit` command**. Changes are automatically snapshotted.

### 2. Mutability & Stability
* **Commits are Mutable:** You can rewrite history, squash, and rebase effortlessly.
* **Change ID (Stable):** Use these for references (e.g., `tqpwlqmp`). They persist even if the content changes.
* **Commit ID (Volatile):** Content hashes (e.g., `3ccf7581`) change whenever the commit is rewritten.

### 3. Revsets (Selection Language)
Use `-r` to target commits:
* `@` : Current working copy.
* `@-` : Parent of working copy.
* `trunk()` : The main remote branch.
* `..@` : All commits from trunk to current.

---

## ESSENTIAL WORKFLOW

### A. The "Describe First" Pattern

1.  Check status: `jj st`
2.  Start new work (if `@` isn't empty): `jj new`
3.  **Set intent:** `jj desc -m "feat: description"`
4.  **Code:** Changes are automatically added to the described commit.

### B. Common Operations

| Task | Command |
| :--- | :--- |
| **View Log** | `jj log` (or `jj log -r 'trunk()..'`) |
| **View Diff** | `jj diff` |
| **Undo** | `jj undo` (Reverts the last `jj` operation) |
| **Abandon** | `jj abandon <change-id>` |
| **Rebase** | `jj rebase -d main` |
| **Sync with Parent** | `jj squash` (Merges current changes into `@-`) |
| **Auto-Cleanup** | `jj absorb` (Distributes changes to previous related commits) |

---

## BOOKMARKS & GIT
* **Bookmarks:** `jj` equivalent to Git branches.
    * Create: `jj bookmark create <name>`
    * Move: `jj bookmark move <name> --to @`
* **Git Sync:**
    * Fetch: `jj git fetch`
    * Push: `jj git push -b <bookmark-name>`
    * **Prohibition:** Never use `git` directly or `jj git` commands not listed here unless explicitly directed.

---

## COMMIT QUALITY STANDARDS
* **Atomicity:** One logical change per commit.
* **Messages:** Imperative mood, sentence case, no trailing period.
    * *Good:* `feat: add authentication middleware`
    * *Bad:* `fixed some bugs.`
* **Refinement:** Use `jj absorb` and `jj squash` frequently to keep history clean before pushing.
