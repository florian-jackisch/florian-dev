---
name: reviewing
description: 'This skill should be used when implementation is complete enough for review, especially before merge. It compares the implementation against the plan, runs a two-reviewer model pair, drives fix-and-rereview loops, and ends with a clear report of changes, findings, open issues, and next steps.'
---

# Reviewing

Use this skill after implementation and verification, especially before merging a feature branch back to `main`.

## Core Principles

- Review against the plan or agreed requirements, not just against the diff in isolation.
- Use two reviewers with different models.
- Fix material findings before calling the work done.
- Re-review after non-trivial fixes.
- End with a clear report of what changed, what reviewers found, and what remains open.

## Required Reviewer Pair

Always include:

- `GPT-5.4`

Choose the second reviewer based on complexity:

- `Claude Sonnet 4.6` for simpler or moderate work
- `Claude Opus 4.6` for complex, high-risk, or multi-system work

## Review Inputs

Gather these before review:

- the implementation plan or requirements
- the branch or commit range under review
- the current verification results
- any known limitations or conscious trade-offs

## Review Workflow

### 1. Baseline check

Before asking for review:

- ensure relevant tests, linters, builds, and checks have run
- ensure the diff is in a coherent state
- stage or otherwise define the exact changes being reviewed

### 2. Run both reviews

Ask both reviewers to check at least:

- correctness against the plan
- missing requirements
- bugs and logic errors
- security or data-loss risks
- regressions
- test adequacy
- dangerous assumptions

Use the bundled `reviewer-prompt.md` as the base prompt.

Launch the reviewers as separate review agents with the `task` tool, not as two sections written in your own context.

- Reviewer 1:
  - `agent_type: "general-purpose"`
  - `model: "gpt-5.4"`
- Reviewer 2:
  - `agent_type: "general-purpose"`
  - `model: "claude-sonnet-4.6"` or `model: "claude-opus-4.6"` based on complexity

For each reviewer, populate the prompt with:

- the plan or requirements
- the commit range or diff under review
- a short summary of what changed
- any known constraints or trade-offs

Do not count the workflow as satisfied unless the reviews came from two separate review-agent runs.

### 3. Normalize findings

Combine the findings into:

- critical
- important
- minor
- disagreements between reviewers

Do not blindly accept every comment. Evaluate whether each issue is technically correct for this repo.

### 4. Fix and verify

Fix critical and important issues before finishing.

After fixes:

- rerun relevant verification
- rerun both reviewers if the changes were meaningful

### 5. Final report

At the end, present:

- what was implemented
- what each reviewer found
- what was fixed
- what remains open
- how you would proceed next

## Complexity Heuristic

Use `Claude Opus 4.6` as the second reviewer when the work involves any of:

- multi-file architectural changes
- auth, security, payments, or data deletion
- migrations or compatibility risk
- concurrency or subtle state management
- broad blast radius or hard-to-test behavior

Otherwise use `Claude Sonnet 4.6`.

## Red Flags

- reviewing only the diff without the plan
- using one reviewer when two were required
- skipping rereview after meaningful fixes
- treating reviewer comments as automatically correct
- declaring success without verification evidence
