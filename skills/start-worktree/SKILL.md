---
name: start-worktree
description: 'This skill should be used after planning approval and before non-trivial coding when work should move into an isolated git worktree on a fresh feature branch. It creates a sibling directory next to the main repository (e.g. `foo.feature-a-thing` alongside `foo`), infers branch naming from repo history when possible, keeps the main checkout on the default branch when practical, and moves subsequent work into the new worktree root.'
---

# Start Worktree

Use this skill after planning is approved and before non-trivial implementation begins.

This skill creates an isolated execution workspace so the main checkout can stay on the default branch while feature work happens in a linked worktree.

## Core Defaults

- place the worktree as a sibling directory next to the main repository
- always create a fresh feature branch
- branch off the repository default branch unless the user explicitly asked for a different base
- infer branch naming from recent non-default branches when a clear style exists
- if no clear style exists, fall back to `feature/<slug>`
- warn if the main checkout is dirty, but still create the worktree from the default branch
- do not run setup or baseline verification by default at worktree creation time
- after creating the worktree, continue the session from the new worktree root
- if the current session name looks generic or default, rename the session to include the new branch name

## Why This Skill Exists

Git worktrees give isolated working directories that share repository storage.

For this workflow, the goal is:

- keep the repository root on the default branch whenever practical
- isolate feature work before code changes begin
- make draft MR branches come from the linked worktree, not from the main checkout

## When to Use

Use this skill:

- after planning approval and before non-trivial coding
- before execution work launched by `auto-draft`
- when you want clean separation between repository root and feature work
- when multiple feature branches may exist locally at the same time

Do not force it for tiny trivial edits where a dedicated worktree would be needless overhead.

## Directory Policy

Default location:

- a sibling directory next to the main repository root, named `<repo-name>.<path-safe-branch-name>`

Example: main repo `foo` on the default branch → sibling `foo.feature-a-thing` for branch `feature/a-thing`.

Because the worktree lives outside the main repository, no `.gitignore` entry is needed for it.

Do not place worktrees inside the repository root.

## Dirty Main Checkout

If the repository root has uncommitted changes:

- warn clearly that the main checkout is dirty
- do **not** use those dirty changes as the base for the new branch
- still create the worktree from the default branch unless another base was explicitly requested

The warning matters because the main checkout should stay understandable, but it is not by itself a reason to block worktree creation.

## Default Branch Selection

Unless the user explicitly asked for something else:

1. identify the repository default branch
2. use that as the base for the new worktree branch

Prefer the branch the repository normally treats as default, not the currently checked out feature branch.

## Branch Naming

Infer the branch naming style from recent non-default branches when a clear pattern exists.

Good examples of patterns:

- `add-...`
- `fix-...`
- `rename-...`
- `strengthen-...`

If a clear local pattern exists, reuse it.

If branch history is mixed or unclear, fall back to:

- `feature/<slug>`

The branch name should be:

- short
- descriptive
- lowercase
- kebab-case after the prefix or verb

If the intended branch name already exists, generate a fresh unique variant rather than reusing the old branch.

## Worktree Path Naming

Place the linked worktree at:

- `../<repo-name>.<path-safe-branch-name>` (sibling to the main repository)

If the branch name contains `/`, replace `/` with `-` to form the path-safe component.

Example:

- repo: `foo`, branch: `feature/user-search`
- path: `../foo.feature-user-search`

## Creation Workflow

### 1. Inspect the repository state

Check:

- repository root and its name
- current branch
- default branch
- dirty main checkout state
- recent non-default branch names for naming inference

### 2. Determine the sibling path

- compute the sibling path as `../<repo-name>.<path-safe-branch-name>`
- verify the path does not already exist

### 3. Create the fresh worktree branch

Create a new linked worktree from the default branch unless the user specified another base.

Do not reuse an existing feature branch by default.

### 4. Switch the session into the worktree

After creation, make the worktree root the active working directory for the rest of the session.

Use the environment's supported working-directory mechanism, such as a persistent shell `cd` or subsequent tool calls rooted at the worktree path.

The session should continue from the worktree root so all subsequent file reads, edits, tests, and commits land there.

### 5. Update the session name when appropriate

After the worktree is ready, check whether the current session name still looks generic or default.

If it does, rename the session so it includes the new branch name.

Good examples:

- `florian-dev: add-session-rename-handoff`
- `repo-name: feature-user-search`

If the session name already looks intentionally custom, keep it.

Do not overwrite a clearly user-chosen session name just to mirror the branch.

### 6. Hand off clearly

At the end, report:

- the branch name
- the worktree path
- the base branch used
- whether the main checkout was dirty
- that subsequent work will run from the worktree root
- whether the session name was updated to include the branch name or deliberately left alone

## Relationship to Other Skills

- `planning` should route approved non-trivial implementation into `start-worktree`
- `coding` should prefer starting from a dedicated worktree rather than coding in the repository root
- `auto-draft` should use this skill before implementation and before draft MR creation
- `git` should treat worktree-backed feature branches as normal sources for draft MRs and may later suggest cleanup without forcing it

## What This Skill Does Not Do by Default

Do not automatically:

- run dependency installation
- run baseline tests
- clean up old worktrees
- merge the branch
- create or update an MR

Those belong to later workflow stages.

## Red Flags

- creating feature work directly in the repository root when a worktree should be used
- branching from the wrong base branch
- staying in the main checkout instead of switching into the new worktree
- reusing an old branch when the user asked for a fresh slice
- letting the main checkout drift away from the default branch unnecessarily
