---
name: git
description: 'This skill should be used when preparing commits, staging changes, splitting work into clean git commits, or handling routine git hygiene. It favors small logical commits, human commit messages under 72 characters, no conventional-commit prefixes, and never adds `Co-authored-by` trailers.'
---

# Git

Use this skill for routine git work around local changes and commits.

This skill is especially for:

- preparing a clean commit from a working tree
- deciding what should be staged together
- writing a brief human commit message
- checking git hygiene before pushing or opening an MR / PR

## Commit Style

Follow this commit style unless the user explicitly asks otherwise:

- never add `Co-authored-by` trailers
- do not use `feat:`, `fix:`, or other conventional-commit prefixes
- keep the summary line human and direct
- keep the summary line under `72` characters
- avoid a body when the summary is enough
- if a body is needed, write one short paragraph only

Good examples:

- `Refine review depth split`
- `Add fleet planning guidance`
- `Fix pipeline status check`

Avoid:

- `feat: add git workflow skill`
- `fix(review): improve reviewer calibration`
- overly clever or vague summaries

## Core Principles

- One logical change per commit.
- Stage intentionally, not blindly.
- Review the diff before committing.
- Do not amend or rewrite history unless the user asks.
- Do not skip hooks unless the user asks.
- Do not force push unless the user asks.

## Commit Workflow

### 1. Inspect the working tree

Before committing:

- check `git status --short`
- inspect the relevant diff
- separate unrelated changes

If the tree contains unrelated work, do not bundle it into the same commit.

### 2. Stage deliberately

Prefer:

- staging specific files
- or using interactive staging when a file mixes unrelated changes

Do not stage generated noise, secrets, or unrelated cleanup by accident.

### 3. Write the message from the actual diff

The summary should describe what changed, not what ticket category it belongs to.

Use:

- an imperative or direct human summary
- concrete wording
- repository language consistent with nearby history

If a body is needed, use it only for context that would otherwise be unclear from the diff.

## When a Body Helps

Add a short one-paragraph body only when:

- the diff has an important trade-off
- the change includes a non-obvious reason
- the summary alone would hide a meaningful constraint

Do not add a body just to restate the diff.

## Pre-Push Hygiene

Before pushing, check:

- the right branch is checked out
- the commit set is coherent
- relevant tests or checks have run
- the branch is appropriate for the work

Do not automatically route git workflow into `final-review`. Use that heavier MR review only when the user explicitly asks for an MR / PR review or draft-undraft decision.

## Safety Rules

- Never commit secrets.
- Never add `Co-authored-by` trailers.
- Never change git config as part of routine commit work.
- Never use destructive history edits without explicit user approval.

## Red Flags

- committing unrelated files together
- auto-generating a message without reading the diff
- using conventional-commit prefixes by habit
- adding a body that says nothing useful
- staging everything because it is easier
