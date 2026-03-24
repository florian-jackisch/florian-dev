---
name: coding
description: 'This skill should be used when implementing a reviewed plan or otherwise executing coding work. It enforces feature-branch hygiene, reuse-first implementation, red/green/refactor execution, many small working commits, formatter/linter/test discipline, and disciplined handoff through deliberate cleanup and end-of-implementation review.'
---

# Coding

Use this skill for implementation work on code changes.

This is the execution counterpart to `planning`.

## Core Principles

- Do not implement substantial work on `main` or the default branch.
- Follow the plan unless there is a concrete reason to adjust it.
- Prefer reusing existing code over creating new abstractions.
- Follow red/green/refactor.
- Treat refactoring as continuous pressure, not just a final cleanup chore.
- Keep commits small, working, and reviewable.
- Verify before claiming progress.

## Git Hygiene First

Before coding:

1. Check for a dirty working tree.
2. Confirm the current branch.
3. If on `main` or the default branch for anything beyond a tiny trivial change, stop and create or switch to a feature branch.
4. If a worktree fits the task, prefer using one.

## Execution Workflow

### 1. Understand the slice

Before touching code:

- restate the task
- identify the files involved
- find adjacent code and tests
- identify existing formatters, linters, build tools, and test commands

### 2. Reuse before inventing

Search for:

- existing helpers
- existing patterns
- similar tests
- existing extension points

Prefer extending an existing path over creating a parallel one unless there is a strong reason not to.

### 3. Red / Green / Refactor

For coding work, the default loop is:

1. write a failing test
2. run it and watch it fail for the expected reason
3. implement the smallest code change that makes it pass
4. rerun the relevant tests
5. refactor while preserving green
6. commit the working state

If the project has no automated tests for the area, create the smallest realistic verification path available and still prove the behavior before moving on.

Small local refactors after a green test are normal. Do not force every working commit to include a broader refactor just for the sake of it.

If structural pressure accumulates across the slice, use `refactoring` for a deliberate cleanup checkpoint before `implementation-review` rather than waiting until final review to notice the debt.

### 4. Commit rhythm

Commit after meaningful green states, not at the very end.

Good commit boundaries:

- one testable behavior
- one bug fix with regression coverage
- one refactor that preserved behavior
- one documentation slice that matches shipped behavior

Do not pile unrelated work into the same commit.

### 5. Verification discipline

Use the project's existing tooling when available:

- formatters
- linters
- type checkers
- builds
- test frameworks

Run the relevant ones as part of the task, not just at the end if that would delay feedback too long.

If the repo lacks one of these tools, do not pretend the check happened. State the limitation clearly.

## End of Implementation Phase

At the end of an implementation phase:

- compare the implementation against the plan
- run `refactoring` first if the slice accumulated meaningful design pressure, duplication, or awkward boundaries that deserve a focused cleanup pass
- run `implementation-review`
- fix material findings
- rerun verification
- rerun implementation review if the fixes are non-trivial

If the next step is MR/PR review or deciding whether a draft MR should be undrafted, run `code-review`.

## When to Pause and Push Back

Stop and question the plan or task if:

- the requested implementation creates obvious tech debt
- the codebase already has a better place to extend
- the task is larger or riskier than the plan assumed
- the test strategy is missing or unrealistic
- implementation would require working directly on `main`

## Non-Coding Work

If the task is primarily documentation, content, or writing rather than executable behavior, use `writing` instead of forcing it through this coding workflow.
