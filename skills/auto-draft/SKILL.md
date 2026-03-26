---
name: auto-draft
description: 'This skill should be used when the user wants a fast autonomous draft-delivery workflow from prompt to draft merge request. It runs lightweight internal brainstorming and planning, implements in a fresh worktree on a fresh branch, opens a new draft MR, runs final review in a capped fix loop, and leaves the result as a user-reviewable draft.'
---

# Auto-Draft

Use this skill when the user wants one explicit command to turn a request into a reviewable draft implementation.

This is an orchestration skill.

It should combine the spirit of:

- `brainstorming`
- `devils-advocate`
- `planning`
- `coding`
- `git`
- `final-review`

without forcing the user through those steps interactively.

## What This Skill Does

`auto-draft` should:

1. understand the request and make reasonable assumptions
2. do lightweight internal brainstorming without asking routine questions
3. create an internal execution-ready plan
4. create and enter a fresh worktree on a fresh branch
5. implement the work
6. open a new draft MR
7. run `final-review`
8. fix substantive findings in a capped loop
9. update the draft MR if needed
10. leave the MR as draft for the user to review manually

## Core Intent

Optimize for speed to a reviewable draft, not merge-readiness.

This skill exists for users who want a fast first draft out the door without manually stepping through brainstorming, planning, implementation, draft MR creation, and review orchestration.

## Explicit Override Scope

This skill is an explicit opt-in override of two normal workflow rules.

### 1. MR text pre-review override

Normal workflow:

- MR title, description, or comment updates should be drafted in Markdown for user review before applying them

`auto-draft` exception:

- because the user explicitly invoked `auto-draft`, this skill may create or update the draft MR text directly
- this exception applies only inside `auto-draft`

### 2. `final-review` routing override

Normal workflow:

- `final-review` should only run on explicit request and should not be auto-routed from other workflows

`auto-draft` exception:

- because the user explicitly invoked `auto-draft`, this skill may run `final-review` internally as part of the autonomous draft-delivery loop
- this exception applies only inside `auto-draft`

Outside this skill, keep following the normal workflow rules.

## Hard Boundaries

Even in autonomous mode:

- do **not** create an issue
- do **not** undraft the MR
- do **not** assign reviewers
- do **not** stop for routine clarification
- do **not** keep looping forever on review findings
- do **not** reuse `main` for implementation
- do **not** quietly code in the repository root when a fresh worktree should be used

## When to Stop and Ask Anyway

This skill should still stop for user input when the action is high-risk or destructive.

Examples:

- destructive data or history operations
- security-sensitive changes with unclear intent
- broad production-impacting changes where the prompt is too ambiguous to infer safely

Normal ambiguity is not enough to stop. Make reasonable assumptions and keep going.

## Worktree Discipline

Before implementation:

1. inspect the repository root
2. warn if the main checkout is dirty
3. invoke `start-worktree` as the worktree-creation phase so this run gets a fresh worktree on a fresh branch from the default branch
4. switch the session into that worktree
5. if the current session name still looks generic or default, rename it to include the fresh branch name

Always create a fresh worktree and a fresh branch for `auto-draft`.

Do not reuse the current branch just because one already exists.

Leave the worktree and branch as-is at the end.

## Internal Workflow

### 1. Internal framing

Start by restating the request internally:

- what outcome the user wants
- what a useful first draft would look like
- what assumptions are reasonable
- what risks or ambiguities matter enough to influence the plan

Do not ask the user routine follow-up questions here.

### 2. Lightweight internal brainstorming

Before planning, quickly pressure-test the idea:

- what is the pragmatic interpretation?
- what is the simplest viable slice?
- what assumption is most likely to be wrong?
- what should be intentionally deferred from the first draft?

Use the reasoning style of `brainstorming` and `devils-advocate`, but keep it internal and concise.

### 3. Internal planning

Create an internal plan that is concrete enough to execute:

- likely files
- likely tests and verification steps
- branch and commit approach
- where Context7 is needed
- what should be in the draft MR description

Use the discipline of `planning`, but do not stop to present the plan unless a real blocker appears.

### 4. Implement in the fresh worktree

Execute with the constraints from `coding`:

- reuse before inventing
- verify current external APIs through Context7 when relevant
- prefer red/green/refactor
- keep commits small and meaningful
- run relevant checks during the work, not only at the end

If the repository lacks tests or other verification, state that clearly in the draft MR.

All implementation work should happen from inside the linked worktree after the session has switched into it. If the session name was still generic, update it to reflect the fresh branch before continuing.

### 5. Create a new draft MR

After the work is coherent enough for review:

- create a **new** draft MR
- keep the title and description short and human
- summarize what changed and why
- document important assumptions or known gaps

Do not undraft it.

Do not assign reviewers.

Do not create an issue.

If blockers remain later, update the same draft MR with those blockers clearly documented.

## Final Review and Fix Loop

Run `final-review` as the internal review stage for this autonomous workflow.

Default loop:

1. run `final-review`
2. fix blocking and important issues when the set is still a reasonable draft-improvement scope
3. rerun relevant verification
4. run `final-review` one more time
5. if the second review surfaces new blocking issues, do at most one final targeted fix pass
6. rerun relevant verification for that final targeted fix pass, but do **not** run `final-review` again
7. stop

Do **not** chase minor nits indefinitely.

Treat the capped loop as a way to improve the draft, not to guarantee perfection.

If the first review surfaces a very large number of blocking or important issues, do not try to grind through an open-ended repair marathon just because they exist.

Instead:

- fix the most important and tractable substantive issues
- document the remaining blockers clearly in the draft MR
- hand the draft back to the user

If blocking issues remain after the capped loop:

- keep the MR as draft
- document the blockers clearly
- hand the result back to the user rather than looping again

## MR Description Style

Keep the draft MR text:

- short
- human
- focused on the goal and current state
- honest about remaining blockers or assumptions

Do not make it changelog-like.

Do not pretend the draft is ready for merge when it is not.

## End State

A good `auto-draft` run ends with:

- a fresh branch containing the work
- a new draft MR
- final review performed
- substantive findings addressed up to the loop cap
- remaining blockers, if any, documented clearly
- no reviewer assignment
- no undrafting

## Handoff Format

At the end, report:

- what was implemented
- what assumptions were made
- what verification ran
- whether a draft MR was created
- what blockers or important follow-ups remain
- that the MR is still draft and ready for manual user review

## Red Flags

- asking routine clarification questions instead of making reasonable assumptions
- reusing an unsafe or dirty working tree
- skipping Context7 where current API knowledge matters
- opening a non-draft MR
- assigning reviewers automatically
- creating an issue as part of the flow
- turning the review/fix loop into an unbounded self-chasing cycle
- claiming the result is merge-ready when significant blockers remain
