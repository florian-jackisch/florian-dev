---
name: checkpoint
description: 'This skill should be used for an in-progress review checkpoint during planning or implementation when you want a quick opposite-family sanity check before continuing. It strengthens the built-in `/review` flow with plan or slice awareness, one-reviewer default calibration, refactoring-pressure checks, and a fast fix-and-continue loop rather than merge-readiness judgment.'
---

# Checkpoint

Use this skill for a light in-progress review checkpoint.

This is not primarily a merge-request review skill. It is the quality check between "I have a plan or working slice" and "I am confident enough to keep going."

## Relationship to Copilot CLI `/review`

GitHub Copilot CLI already provides built-in `/review`.

Think of this skill as an enhancement layer for `/review`, not a replacement for it.

Use built-in review as the baseline, then strengthen it by adding:

- comparison against the current plan, slice, or agreed scope
- a default one-reviewer path
- preference for an opposite-family reviewer when practical
- an explicit check for refactoring pressure or scope drift
- a fast fix-and-rereview loop aimed at continuing work, not merge readiness

## When to Use

Use this skill:

- after a planning pass when you want a quick reality check before implementation starts
- during implementation when a slice is green but worth sanity-checking before the next step
- when a change feels coherent but you want one fresh reviewer family to challenge it
- before escalating to a heavier final MR review

If the goal is to review an MR/PR as a review artifact, decide whether a draft MR is ready to undraft, or produce a merge-oriented verdict, stop using this lighter workflow and switch to the dedicated MR review skill on explicit request.

## Core Principles

- Review against the current plan, idea, or slice goal, not just the diff in isolation.
- Keep the checkpoint cheap enough that it can happen during planning or coding.
- Default to one reviewer.
- When possible, choose a reviewer from the model family that did **not** produce most of the current work.
- Ask whether the design should be cleaned up further before continuing.
- Fix material findings before moving on.
- Re-review after meaningful fixes when the same uncertainty still exists.

## Reviewer Choice

Use one reviewer only.

- if the current work was mainly done by a GPT-family model, prefer `Claude Sonnet 4.6 review`
- if the current work was mainly done by a Claude-family model, prefer `GPT-5.4 review`
- if the implementation family is unclear, choose one reviewer and still prefer the opposite family when you can

Escalate beyond one reviewer only if the "light" checkpoint has clearly stopped being light. At that point, either split the work into smaller slices or pause and decide deliberately whether a heavier review is actually needed.

## Review Inputs

Gather these before review:

- the plan, slice goal, or agreed scope
- the relevant diff, files, or commit range
- current verification results
- what refactoring was done, skipped, or consciously deferred
- known trade-offs or open questions

## Review Workflow

### 1. Baseline check

Before review:

- ensure the plan or current slice is coherent enough to inspect
- ensure relevant tests, builds, linters, or checks have run when they exist
- gather the current plan or scope context
- confirm whether a deliberate `refactoring` checkpoint was warranted and, if so, whether it happened

If a refactoring checkpoint was clearly warranted but skipped, do not just note it and continue. Route the work back through `refactoring`, verify again, and then resume the checkpoint review.

### 2. Run one opposite-family reviewer

Use the bundled `reviewer-prompt.md` as the base prompt.

Launch one focused review agent with the `task` tool instead of relying on one long self-review in your own context.

- if current work was mainly GPT-family, use `Claude Sonnet 4.6 review`: `agent_type: "general-purpose"`, `model: "claude-sonnet-4.6"`
- if current work was mainly Claude-family, use `GPT-5.4 review`: `agent_type: "general-purpose"`, `model: "gpt-5.4"`
- if the family is unclear, pick one reviewer and still prefer the opposite family when you can

Populate the prompt with:

- the plan or slice goal
- the relevant diff or file set
- a short summary of what changed
- verification results
- known constraints or open questions

### 3. Normalize findings

Combine the findings into:

- blocking for continuing
- important but local
- minor
- refactoring pressure that should be handled before continuing

Do not treat reviewer comments as automatically correct. Evaluate them against repo reality and the current phase of work.

### 4. Fix and continue

Fix blocking and important issues before moving on.

After meaningful fixes:

- rerun relevant verification
- rerun the checkpoint if the same uncertainty still matters

### 5. Hand off clearly

At the end, present:

- what was checked
- what the reviewer found
- what was fixed
- what was intentionally deferred
- whether to continue coding, refactor first, or pause for a deliberate heavier review decision

## What This Skill Is Not For

Do not use this skill as the primary workflow for:

- final MR/PR review
- approval-style merge decisions
- deciding whether a draft MR is ready to undraft as a final gate

Use the dedicated MR review skill for those, but only when that heavier review is explicitly requested.

## Red Flags

- treating this as a merge-ready verdict
- running heavy multi-reviewer review by default
- reviewing without the plan or current slice context
- using this as an excuse to skip verification
- continuing while obvious duplication, awkward boundaries, or design pressure remain unaddressed
