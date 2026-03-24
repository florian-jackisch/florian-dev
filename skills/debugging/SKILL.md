---
name: debugging
description: 'This skill should be used when the user reports a bug, failing test, regression, flaky behavior, performance issue, or broken integration. It enforces evidence-first debugging, root-cause analysis, minimal hypothesis testing, and fix verification before implementation.'
---

# Debugging

Use this skill to debug systematically instead of guessing.

## Core Principle

**Do not propose or implement fixes before investigating the root cause.**

Quick patches often hide the real problem and create more work later. The goal is to understand what is failing, why it is failing, and where the failure truly begins.

## When to Use

Use this skill for:

- failing tests
- runtime errors
- unexpected behavior
- flaky or intermittent failures
- performance regressions
- build or CI breakage
- integration issues across multiple systems

Use it especially when:

- the bug looks deceptively simple
- time pressure is pushing toward guesswork
- multiple attempted fixes already failed
- the failure appears far away from its real cause

## The Process

You must complete each phase in order.

### Phase 1: Investigate the Root Cause

Before suggesting any fix:

1. Read the full error, logs, warnings, and stack trace carefully.
2. Reproduce the issue or state clearly that reproduction is incomplete.
3. Check recent changes that could explain the failure.
4. Gather evidence at component boundaries if several systems are involved.
5. Trace the failure backward until you find the original trigger.

Use `root-cause-analysis.md` in this directory when the bug is surfacing deep inside a call chain or workflow.

### Phase 2: Compare Against Reality

Find the pattern before changing code:

1. Locate similar working code, behavior, or configuration.
2. Compare the working and broken cases completely.
3. List the meaningful differences explicitly.
4. Check assumptions about environment, data, timing, and dependencies.

### Phase 3: Form One Hypothesis

Use the scientific method:

1. State one hypothesis clearly: "I think X is happening because Y."
2. Test that hypothesis with the smallest useful diagnostic or change.
3. Verify the result.
4. If the hypothesis fails, stop and form a new one instead of stacking fixes.

### Phase 4: Fix and Verify

Once the cause is known:

1. Create the smallest failing reproduction or regression test possible.
2. Implement one focused fix.
3. Re-run the relevant verification.
4. Confirm the original bug is gone and adjacent behavior still works.

If several fixes fail in a row, stop treating it as a local bug and question the broader design or architecture.

## Rules During Debugging

- Change one thing at a time.
- Prefer evidence over intuition.
- Prefer instrumentation over speculation.
- Prefer minimal reproductions over large manual test flows.
- Prefer fixing the source over patching the symptom.

## Research

If the issue involves third-party systems, framework behavior, hosting, browser/runtime differences, or unclear library semantics, look up current documentation or reputable references before deciding on a fix.

## Red Flags

If you catch any of these, stop and go back to investigation:

- "quick fix for now"
- "let's just try this"
- several unrelated changes at once
- fix proposals without traced evidence
- assuming the first plausible cause is the real one
- skipping reproduction because the issue seems obvious

## Expected Output

Communicate debugging progress in this order:

1. symptom
2. evidence
3. likely root cause
4. smallest next test or fix
5. verification result

Keep the reasoning concrete and evidence-based.
