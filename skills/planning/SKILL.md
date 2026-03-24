---
name: planning
description: 'This skill should be used when the user asks to "plan this", "write an implementation plan", "turn this idea into a plan", or wants to make built-in `/plan` or plan mode more specific and execution-ready. It turns a clear idea into a concrete execution plan with exact files, feature-branch expectations, red/green TDD steps, frequent working commits, and a plan review loop before implementation begins.'
---

# Planning

Use this skill when the idea is clear enough to plan but implementation has not started yet.

This skill is the bridge between an idea being clear and implementation beginning.

It is not primarily a requirements-writing skill. Use it after `brainstorming`, `interview`, or `devils-advocate` produced enough clarity that the next useful step is an execution-ready plan.

## Relationship to Copilot CLI Plan Mode

GitHub Copilot CLI already provides `/plan` and a plan mode reachable via `Shift+Tab`.

Use that built-in planning flow as the default place to draft and maintain the human-readable plan.

Think of this skill as an enhancement layer for built-in planning, not a replacement for it.

Use `/plan` or plan mode to create and maintain the plan, then use this skill to make the plan more specific, more executable, and more disciplined.

Specifically, this skill should make the built-in plan:

- more concrete about files and task boundaries
- more explicit about feature branches or worktrees
- more rigorous about red/green TDD
- more explicit about verification steps
- more deliberate about frequent working commits
- more likely to survive a review before coding starts

## Core Principles

- Do not implement while planning.
- Plan on a feature branch or dedicated worktree, not on `main` or the default branch.
- Prefer red/green/refactor task breakdowns.
- Keep tasks small enough to produce frequent working commits.
- Review the plan before implementation starts.

## Before Writing the Plan

1. Confirm the problem is well understood.
2. If important details are still unclear, use `interview` or `brainstorming` first.
3. Check whether the work should happen on a feature branch or in a worktree.
4. If already on `main` or the default branch for meaningful implementation work, stop and create or request a feature branch before continuing.

## What the Plan Must Contain

Every implementation plan should include:

- the goal in one sentence
- the proposed architecture or approach
- the files likely to change or be created
- explicit assumptions and constraints
- a task sequence that an implementer can follow without guessing
- the verification approach for each task
- the commit rhythm

## Task Structure

Break work into small, testable slices.

For coding tasks, prefer this shape:

1. write the failing test
2. run it and confirm it fails for the right reason
3. implement the smallest change to make it pass
4. rerun relevant tests
5. refactor if needed while staying green
6. commit a working state

Do not bundle many red/green cycles into one giant task.

## Plan Quality Bar

A good plan is:

- specific enough that file paths and responsibilities are visible
- small-step enough that progress can be checked continuously
- realistic about testing, migration, rollout, and risk
- explicit about where linters, formatters, builds, and tests fit
- aligned with existing repo patterns instead of inventing a new architecture casually

## Branch and Commit Discipline

Assume implementation will happen away from `main`.

The plan should explicitly call for:

- a feature branch or worktree
- many small working commits
- commit points after meaningful green states
- review before merge back to `main`

## Review the Plan Before Execution

Before implementation starts, challenge the plan.

Use the bundled `plan-reviewer-prompt.md` as a review template for a focused reviewer pass.

Launch a focused review sub-agent with the `task` tool:

- `agent_type: "general-purpose"`
- `model: "gpt-5.4"`

Populate the prompt template with the actual plan and the source idea, constraints, or scope summary before dispatching it. Do not review the plan only in your own context if you can launch a reviewer sub-agent.

The review should check:

- missing intent coverage
- vague or non-actionable steps
- task ordering problems
- hidden risks or scope creep
- whether the TDD and verification path is actually executable

If the review finds real gaps, fix the plan and review it again.

## Handoff to Execution

Once the plan is approved, execution should normally use:

- `coding` for implementation work
- `writing` for documentation-heavy tasks
- `reviewing` before merge or final sign-off

## Red Flags

Stop and rework the plan if:

- tasks are too large to finish safely in one green cycle
- the plan skips tests until the end
- the plan assumes implementation on `main`
- file changes are vague
- there are no explicit verification steps
- commit points are missing
