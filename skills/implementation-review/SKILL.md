---
name: implementation-review
description: 'This skill should be used at the end of an implementation phase, after coding, verification, and any needed cleanup, to compare the implementation against the plan or agreed scope. It strengthens the built-in `/review` flow with plan awareness, refactoring-pressure checks, light default review for routine slices, deeper review only for large or high-risk work, and a final implementation handoff report.'
---

# Implementation Review

Use this skill at the end of an implementation phase.

This is not primarily a merge-request review skill. It is the quality gate between "I finished implementing this slice" and "I am ready to hand it off, open/update a merge request, or move to the next phase."

## Relationship to Copilot CLI `/review`

GitHub Copilot CLI already provides built-in `/review`.

Think of this skill as an enhancement layer for `/review`, not a replacement for it.

Use built-in review as the baseline review mechanism, then strengthen it by adding:

- comparison against the implementation plan or agreed scope
- explicit change-size calibration
- a light default review path for routine implementation slices
- a second reviewer only for large or high-risk implementation work
- an explicit check for refactoring pressure before the phase is called complete
- a fix-and-rereview loop
- a final report of what changed, what reviewers found, and what remains open

## When to Use

Use this skill:

- when an implementation slice is complete enough to evaluate
- after coding, verification, and any deliberate refactoring checkpoint have run
- before calling an implementation phase done
- before handing work off for MR review or broader team review

If the goal is to review an MR/PR as a review artifact, or decide whether a draft MR is ready to undraft, use `code-review` instead.

## Core Principles

- Review against the plan, idea, or agreed scope, not just the diff in isolation.
- Use review depth proportional to change complexity.
- For routine implementation slices, prefer one reviewer instead of two.
- When possible, choose a reviewer from the model family that did **not** do the implementation.
- Ask whether the design should be cleaned up further before the phase is called complete.
- Fix material findings before calling the phase complete.
- Re-review after meaningful fixes.
- End with a concise implementation report.

## Complexity Levels

### Light changes

Examples:

- small additive changes
- localized bug fixes
- small refactors with narrow blast radius
- focused docs that accompany a tiny code change

Use:

- one reviewer only
- if implementation was mainly done by a GPT-family model, prefer `Claude Sonnet 4.6 review`
- if implementation was mainly done by a Claude-family model, prefer `GPT-5.4 review`
- if the implementation family is unclear, choose one reviewer and still prefer the opposite family when you can

### Medium changes

Examples:

- multi-file feature work
- non-trivial refactors
- important behavior changes
- work with moderate blast radius

Use:

- start with one primary reviewer
- prefer the opposite family from the implementation when that is known
- keep this as a one-reviewer path unless the slice is effectively large or high-risk in practice

### Hard changes

Examples:

- architecture-heavy work
- auth, security, payments, or deletion flows
- migrations or compatibility risk
- concurrency or subtle state management
- broad blast radius or hard-to-test behavior

Use:

- reviewer 1: `GPT-5.4`
- reviewer 2: `Claude Opus 4.6`

## Review Inputs

Gather these before review:

- the implementation plan, source idea, or agreed scope
- the diff or commit range under review
- the current verification results
- what refactoring was done, skipped, or consciously deferred
- known limitations, trade-offs, or deferred work

## Review Workflow

### 1. Baseline check

Before review:

- ensure relevant tests, builds, linters, and checks have run
- ensure the diff is in a coherent state
- gather the plan or scope context
- confirm whether a deliberate `refactoring` checkpoint was warranted and, if so, whether it happened

If the checkpoint was warranted but skipped, do not just note it and continue. Route the work back through `refactoring`, verify again, and then resume review.

### 2. Run the reviewer set

Use the bundled `reviewer-prompt.md` as the base prompt.

Launch separate review agents with the `task` tool, not one long self-review in your own context.

- Light:
  - choose exactly one reviewer
  - if implementation was mainly GPT-family work, use `Claude Sonnet 4.6 review`: `agent_type: "general-purpose"`, `model: "claude-sonnet-4.6"`
  - if implementation was mainly Claude-family work, use `GPT-5.4 review`: `agent_type: "general-purpose"`, `model: "gpt-5.4"`
  - if the implementation family is unclear, pick one reviewer and still prefer the opposite family when you can
- Medium:
  - start with one primary reviewer from the opposite family when possible
  - if implementation was mainly GPT-family work, start with `Claude Sonnet 4.6 review`: `agent_type: "general-purpose"`, `model: "claude-sonnet-4.6"`
  - if implementation was mainly Claude-family work, start with `GPT-5.4 review`: `agent_type: "general-purpose"`, `model: "gpt-5.4"`
  - if the slice proves large or high-risk in practice, treat it as a hard review instead of quietly growing the medium path
- Hard:
  - `GPT-5.4 review`: `agent_type: "general-purpose"`, `model: "gpt-5.4"`
  - `Claude Opus 4.6 review`: `agent_type: "general-purpose"`, `model: "claude-opus-4.6"`

For each reviewer, populate the prompt with:

- the implementation plan or scope
- the diff or commit range
- a short summary of what changed
- verification results
- known constraints or trade-offs

### 3. Normalize findings

Combine the findings into:

- critical
- important
- minor
- refactoring pressure that should be handled before the phase is considered done
- reviewer disagreements

Do not treat reviewer comments as automatically correct. Evaluate them against repo reality.

### 4. Fix and verify

Fix critical and important issues before calling the implementation phase complete.

After meaningful fixes:

- rerun relevant verification
- rerun the reviewer set for the same complexity level

### 5. Final report

At the end, present:

- what was implemented
- what the reviewer or reviewers found
- what was fixed
- what refactoring was performed or explicitly deferred
- what remains open
- how you would proceed next

## What This Skill Is Not For

Do not use this skill as the primary workflow for:

- reviewing someone else's MR/PR in its review system context
- deciding whether a draft MR should be undrafted
- general code review comments on an open MR

Use `code-review` for those.

## Red Flags

- treating this as purely a pre-merge gate
- reviewing without the plan or scope context
- using two reviewers for tiny changes by default
- adding a second reviewer to routine implementation slices without a real size or risk reason
- skipping the second reviewer on hard work
- skipping rereview after meaningful fixes
- calling the phase done while obvious duplication, awkward boundaries, or design pressure remains unaddressed
- declaring the implementation phase done without verification evidence
