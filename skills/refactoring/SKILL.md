---
name: refactoring
description: 'This skill should be used when code should be refactored, technical debt should be reduced, a design should be cleaned up, or a workflow calls for a deliberate cleanup pass before `checkpoint`. It focuses on behavior-preserving change, small safe steps, and choosing between local red/green/refactor cleanup and a dedicated refactoring checkpoint.'
---

# Refactoring

Use this skill when the goal is to improve the structure of existing code without changing its intended behavior.

This skill complements `coding` and `checkpoint`.

- use `coding` for feature or bug-fix execution
- use `refactoring` when cleanup needs deliberate focus
- use `checkpoint` to check whether important refactoring pressure was ignored

## Core Rules

- Preserve behavior. Refactoring changes structure, not product intent.
- Work in small safe steps.
- Do not mix a large refactor with unrelated feature work in the same step.
- Do not refactor without a realistic verification path.
- Prefer improving an existing path over introducing parallel abstractions.

## When to Use

Use this skill when:

- code is hard to extend, name, or reason about
- duplication is spreading across a feature slice
- a red/green cycle passed, but the result is awkward or brittle
- the next useful step is cleanup before `checkpoint`
- a review found structural issues that should be fixed before the phase is called done

## When Not to Use

Do not use this skill for:

- feature work that still lacks a passing baseline
- speculative rewrites with no clear benefit
- broad cleanup of untested critical code with no safety net
- mixing many unrelated cleanups into one hard-to-review diff

## Recommended Cadence

The default workflow is hybrid:

1. **Local red/green/refactor cleanup**
   - After a test turns green, do the small cleanup that obviously improves clarity.
   - Examples: rename for clarity, extract a helper, remove duplication introduced by the change, simplify branching.
2. **Deliberate refactoring checkpoint**
   - If design pressure accumulates across a slice, pause before `checkpoint` and do a focused cleanup pass.
   - Use this when the right cleanup crosses files, reshapes boundaries, or deserves its own verification pass.
3. **Checkpoint backstop**
   - `checkpoint` should still ask whether material refactoring opportunities were left behind.

Do **not** force every working commit to include refactoring. Small cleanup is normal; bigger cleanup should be explicit.

## Signals That a Dedicated Refactoring Checkpoint Is Warranted

Pause for a focused cleanup pass when you notice:

- the same logic repeated in more than one new or touched location
- a function or class now has multiple responsibilities
- new conditionals are multiplying around type or mode checks
- tests became much harder to write because boundaries are awkward
- naming, parameter lists, or data flow became harder to explain after the feature passed
- the right fix is clear, but it would distract from the current red/green slice unless separated

## Refactoring Workflow

### 1. Lock behavior down

Before refactoring:

- identify the current behavior that must stay true
- run the relevant existing tests or checks
- add the smallest missing coverage if behavior is not protected enough

If you cannot verify behavior at all, stop and create a safer path first.

### 2. Choose the smallest valuable move

Prefer one focused change at a time:

- extract method or helper
- remove duplication
- split responsibilities
- improve names
- replace awkward branching with clearer structure
- introduce a better boundary or parameter object

### 3. Keep steps reviewable

For each step:

1. make one structural change
2. rerun relevant verification
3. confirm behavior still matches intent
4. decide whether another small step is still justified

### 4. Stop at the right point

Stop when:

- the code is materially clearer
- the current slice is easier to extend or review
- another cleanup step would become speculative

Leave a note for follow-up work instead of continuing into a rewrite.

## Refactoring Checklist

- [ ] Behavior is still the same from the user's point of view
- [ ] The changed code is easier to explain than before
- [ ] Duplication was reduced rather than moved
- [ ] Responsibilities are clearer
- [ ] Naming became more precise
- [ ] Verification ran after each meaningful cleanup step
- [ ] Deferred cleanup, if any, is explicit

## Handoff

At the end of a deliberate refactoring pass, summarize:

- what code was cleaned up
- what behavior was preserved
- what verification ran
- what cleanup was intentionally deferred

If the implementation slice is otherwise complete, move to `checkpoint`.
