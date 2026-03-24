---
name: code-review
description: 'This skill should be used when reviewing a merge request or pull request, when asked to perform a code review, or when checking whether your own draft MR/PR is in good enough shape to be undrafted. It drives a practical review workflow focused on correctness, risk, test coverage, reviewer comments, and a clear review verdict.'
---

# Code Review

Use this skill for MR/PR review work.

This includes:

- reviewing someone else's merge request or pull request
- reviewing your own branch or MR before requesting review
- deciding whether your own draft MR is ready to be undrafted

## Relationship to Copilot CLI `/review`

GitHub Copilot CLI already provides built-in `/review`.

Use that as the default review engine when it fits, then strengthen the review with MR/PR context, CI awareness, and an explicit verdict.

## Review Goals

A good code review should answer:

- does this change do what it claims?
- is it safe to merge or at least safe to leave draft?
- what important issues remain?
- what feedback is blocking versus advisory?

## Context First

Before reviewing code, gather context:

- the MR/PR title and description
- linked issue or plan if available
- whether the MR is draft or ready
- CI or verification status
- scope and size of the change

If the review target is your own draft MR, explicitly ask:

- is the implementation coherent?
- are key tests and checks in place?
- are the remaining issues draft-worthy blockers or normal review comments?

## Review Workflow

### 1. High-level review

Check:

- does the approach make sense?
- is it consistent with repo patterns?
- is the change appropriately scoped?
- is the file organization sensible?

### 2. Detailed review

Review for:

- correctness and edge cases
- regressions or dangerous assumptions
- security risks
- performance issues
- test adequacy
- maintainability and clarity
- documentation updates where needed

Do not waste time on formatting and import nits that tools should handle.

### 3. Reviewer mindset

Be constructive and specific.

Good review comments should:

- point to the exact issue
- explain why it matters
- distinguish blocking from non-blocking
- suggest a direction when useful

### 4. Verdict

End with a clear verdict.

For reviewing someone else's MR/PR:

- Approve
- Comment / non-blocking feedback
- Request changes

For reviewing your own draft MR/PR:

- Keep draft
- Ready to undraft
- Ready to undraft after small fixes

## Draft-vs-Ready Heuristic

A draft MR should usually stay draft if:

- the implementation is still structurally incomplete
- core verification is missing
- key reviewer-facing context is missing
- known blockers are still unresolved
- the diff is not yet coherent enough for review

A draft MR is usually ready to undraft if:

- the implementation goal is visible and coherent
- critical checks have run or the remaining gaps are clearly explained
- the description/context is sufficient for a reviewer
- remaining issues are normal review comments, not draft blockers

## Output Format

### Strengths
- ...

### Blocking
- [issue] - [why it matters]

### Important
- [issue] - [why it matters]

### Minor
- [issue] - [why it matters]

### Verdict
- [Approve | Comment | Request changes | Keep draft | Ready to undraft | Ready to undraft after small fixes]

### Reasoning
- ...

## Red Flags

- reviewing without reading the MR/PR context
- focusing on style while missing logic or test gaps
- failing to separate blocking from advisory feedback
- saying a draft is ready when core checks are still missing
- using implementation-review when the real task is MR/PR review
