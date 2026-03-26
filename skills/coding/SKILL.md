---
name: coding
description: 'This skill should be used when implementing a reviewed plan or otherwise executing coding work. It enforces feature-branch hygiene, reuse-first implementation, Context7-backed API verification, red/green/refactor execution, many small working commits, formatter/linter/test discipline, and disciplined handoff through deliberate cleanup and end-of-implementation review.'
---

# Coding

Use this skill for implementation work on code changes.

This is the execution counterpart to `planning`.

## Core Principles

- Do not implement substantial work on `main` or the default branch.
- Follow the plan unless there is a concrete reason to adjust it.
- Prefer reusing existing code over creating new abstractions.
- Use Context7 to confirm current external library and framework APIs before coding against them.
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
- identify any external libraries, frameworks, or SDKs whose current APIs should be confirmed through Context7

### 2. Reuse before inventing

Search for:

- existing helpers
- existing patterns
- similar tests
- existing extension points

Prefer extending an existing path over creating a parallel one unless there is a strong reason not to.

### 2.5. Check external APIs before inventing usage

When the slice depends on a library, framework, SDK, or third-party API surface:

1. use Context7 to confirm the current API shape and recommended usage
2. prefer repository-local patterns when they already use the same dependency correctly
3. do not invent methods, options, or config keys from memory when the docs are available

Use your memory for orientation, not for final API assumptions.

If Context7 cannot return useful results and the repository has no trustworthy local usage to copy, state that limitation explicitly before proceeding and only rely on behavior you can verify directly in code, tests, or tool output.

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

If structural pressure accumulates across the slice, use `refactoring` for a deliberate cleanup checkpoint before `checkpoint` rather than waiting until final review to notice the debt.

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

If the task relies on an external dependency and you did not confirm the relevant API through repo-local usage or Context7, do not pretend that lookup happened.

## End of Implementation Phase

At the end of an implementation phase:

- compare the implementation against the plan
- run `refactoring` first if the slice accumulated meaningful design pressure, duplication, or awkward boundaries that deserve a focused cleanup pass
- run `checkpoint`
- fix material findings
- rerun verification
- rerun the checkpoint if the fixes are non-trivial

Do not automatically route implementation work into `final-review`. That heavier MR review should only happen on explicit request, such as when asked to review the MR or decide whether a draft is ready to undraft.

Exception:

- if the user explicitly invoked `auto-draft`, that orchestration skill may run `final-review` internally as part of its bounded draft-delivery loop

## When to Pause and Push Back

Stop and question the plan or task if:

- the requested implementation creates obvious tech debt
- the codebase already has a better place to extend
- the task is larger or riskier than the plan assumed
- the test strategy is missing or unrealistic
- implementation would require working directly on `main`

## Non-Coding Work

If the task is primarily documentation, content, or writing rather than executable behavior, use `writing` instead of forcing it through this coding workflow.
