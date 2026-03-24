# Root Cause Analysis

Use this guide when the bug appears in one place but likely started somewhere else.

## Principle

Do not stop at the first visible failure.

Most bugs surface at the point where the system finally notices something is wrong, not where the wrong thing first happened. Trace backward until you find the earliest meaningful cause.

## When to Use

Use this when:

- the stack trace is deep
- several components are involved
- bad data appears far downstream
- a symptom keeps returning after superficial fixes
- a flaky issue appears only under certain timing or environment conditions

## The Backward Tracing Method

### 1. Observe the Symptom

Write down exactly what failed:

- the error
- the unexpected behavior
- where it surfaced
- what was expected instead

Avoid interpretation at this step. Just capture the facts.

### 2. Find the Immediate Cause

Ask:

- what line, function, query, command, request, or state transition directly produced the failure?
- what input or state did it receive?

This is not the root cause yet. It is only the first visible break.

### 3. Ask "Where did that input/state come from?"

Trace one step backward:

- who called it?
- what passed that value?
- what earlier state made this possible?

Repeat this until you stop finding upstream causes.

### 4. Identify the Earliest Meaningful Trigger

The root cause is usually the first place where:

- invalid data entered the system
- an incorrect assumption was made
- a state transition went wrong
- timing or ordering broke an expectation
- an environment/configuration difference changed behavior

That is the point to fix.

### 5. Add Defenses After the Fix

Once the source is known:

- fix it at the source
- add validation or guards at key boundaries
- add a regression test or reproduction
- improve observability if this was hard to diagnose

## Useful Questions

- What changed recently?
- What is different between the working and broken case?
- What assumption is being violated?
- Where did the bad value first appear?
- Which earlier layer should have rejected or transformed this?
- Is this actually a local bug, or a symptom of a wider design problem?

## Multi-Component Systems

When several components are involved, gather evidence at each boundary:

- input to component A
- output from component A
- input to component B
- output from component B

Do not guess which layer is broken. Instrument the path and see where reality diverges from expectation.

## Signs You Are Still Too Close to the Symptom

- your fix only changes the line that crashes
- you cannot explain where the bad input came from
- the proposed fix adds fallback behavior without explanation
- you are treating logs as noise instead of evidence
- each fix reveals a new nearby problem

## If Three Fixes Fail

Stop and reconsider the broader architecture.

Repeated failed fixes often mean the root problem is structural:

- hidden coupling
- invalid abstraction
- shared mutable state
- weak boundaries
- incorrect mental model of the system

At that point, the right move is usually not "one more patch."
