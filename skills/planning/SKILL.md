---
name: planning
description: 'This skill should be used when the user asks to "plan this", "write an implementation plan", "turn this idea into a plan", or wants to make built-in `/plan` or plan mode more specific and execution-ready. It turns a clear idea into a concrete execution plan with exact files, feature-branch expectations, red/green/refactor steps, deliberate cleanup checkpoints when needed, Context7-backed API and library lookup planning, suggestions for built-in `/fleet` when work splits into well-bounded independent parallel slices, frequent working commits, and a plan review loop before implementation begins.'
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
- more deliberate about where refactoring should happen
- more deliberate about when Context7 should be used to confirm current library and framework APIs
- more explicit about when independent work should use built-in `/fleet`
- more explicit about verification steps
- more deliberate about frequent working commits
- more likely to survive a review before coding starts

## Core Principles

- Do not implement while planning.
- Plan on a feature branch or dedicated worktree, not on `main` or the default branch.
- For non-trivial implementation work, prefer handing off into `start-worktree` after plan approval so execution happens in an isolated linked worktree rather than the repository root.
- Prefer red/green/refactor task breakdowns.
- Plan explicit refactoring checkpoints when design pressure is likely to accumulate.
- Plan when Context7 should be used to confirm current external APIs, framework behavior, and library usage instead of relying on memory.
- Suggest built-in `/fleet` when the plan contains independent, well-bounded tasks that can be executed in parallel.
- Keep tasks small enough to produce frequent working commits.
- Review the plan before implementation starts.

## Before Writing the Plan

1. Confirm the problem is well understood.
2. If important details are still unclear, use `interview` or `brainstorming` first.
3. Check whether the work should happen on a feature branch or in a worktree.
4. If already on `main` or the default branch for meaningful implementation work, stop and create or request a feature branch before continuing.

For this workflow, treat a dedicated worktree as the default handoff for non-trivial coding unless there is a strong reason to keep the work in the current checkout.

## What the Plan Must Contain

Every implementation plan should include:

- the goal in one sentence
- the proposed architecture or approach
- the files likely to change or be created
- explicit assumptions and constraints
- if the work depends on external libraries or frameworks, which ones need current API confirmation via Context7
- a task sequence that an implementer can follow without guessing
- the verification approach for each task
- where refactoring should happen if the work is likely to create structural pressure
- whether any tasks should be delegated via built-in `/fleet`
- how parallel results, if any, will be integrated and verified afterward
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

For medium or hard work, the plan should also say whether there should be a deliberate `refactoring` checkpoint before `checkpoint`.

When the work naturally splits into independent domains, the plan should also say whether built-in `/fleet` should be used for parallel subagents.

Good `/fleet` candidates usually have:

- clearly separated files, subsystems, or failure domains
- minimal shared state between tasks
- well-defined inputs and expected outputs for each subagent
- integration work that can happen after the parallel slices return

Avoid suggesting `/fleet` when:

- tasks are tightly coupled and likely to affect the same files
- one investigation will probably resolve the others
- the work depends on a shared evolving design that should stay in one context

## Plan Quality Bar

A good plan is:

- specific enough that file paths and responsibilities are visible
- small-step enough that progress can be checked continuously
- realistic about testing, migration, rollout, and risk
- explicit about where current library or framework docs should be consulted through Context7
- explicit about where linters, formatters, builds, and tests fit
- aligned with existing repo patterns instead of inventing a new architecture casually

## Branch and Commit Discipline

Assume implementation will happen away from `main`.

The plan should explicitly call for:

- a feature branch or worktree
- for non-trivial coding, `start-worktree` as the normal execution handoff after plan approval
- many small working commits
- commit points after meaningful green states
- a separate refactoring checkpoint when the work is likely to build design pressure faster than it can be cleaned up locally
- review checkpoints before handoff and before merge back to `main`

## Review the Plan Before Execution

Before implementation starts, challenge the plan.

Use the bundled `plan-reviewer-prompt.md` as a review template for a focused reviewer pass.

Launch a focused review sub-agent with the `task` tool:

- `agent_type: "general-purpose"`
- `model: "gpt-5.4"`
- use an explicit label such as `GPT-5.4 plan review`

Populate the prompt template with the actual plan and the source idea, constraints, or scope summary before dispatching it. Do not review the plan only in your own context if you can launch a reviewer sub-agent.

The review should check:

- missing intent coverage
- vague or non-actionable steps
- task ordering problems
- missed opportunities to use built-in `/fleet` for truly independent work
- hidden risks or scope creep
- places where the plan assumes library APIs without checking current documentation
- whether the TDD and verification path is actually executable

If the review finds real gaps, fix the plan and review it again.

## Handoff to Execution

Once the plan is approved, execution should normally use:

- `start-worktree` before non-trivial implementation so the session moves into an isolated worktree rooted at `.worktrees/`
- `coding` for implementation work
- `refactoring` for deliberate cleanup before the end of an implementation phase
- `mermaid` when the plan or architecture outline would be clearer with diagrams in Markdown
- `writing` for documentation-heavy tasks
- `checkpoint` when planning or implementation work should pause for a light opposite-family sanity check before continuing

Built-in `/fleet` is an orchestration tool, not a replacement for those workflows.

Context7 is a workflow dependency, not a separate planning replacement.

If the plan depends on external libraries, frameworks, SDKs, or APIs, call out where implementation should consult Context7 before coding the integration details.

If the plan recommends built-in `/fleet`, specify:

- which tasks should become parallel subagents
- the boundary for each subagent
- what context each subagent needs
- how results will be integrated and verified afterward

Parallel subagents should still execute through the normal workflow for their slice:

- use `coding` for code-producing subagents
- use `mermaid` when a subagent's output should include Mermaid diagrams in Markdown
- use `writing` for documentation-heavy subagents
- return to the main execution flow to integrate results, rerun verification, and continue toward `checkpoint` or ordinary implementation work as appropriate

## Red Flags

Stop and rework the plan if:

- tasks are too large to finish safely in one green cycle
- the plan skips tests until the end
- the plan assumes implementation on `main`
- the plan suggests `/fleet` for tightly coupled work without clear boundaries
- file changes are vague
- there are no explicit verification steps
- commit points are missing
