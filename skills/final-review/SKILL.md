---
name: final-review
description: 'This skill should be used when reviewing a merge request or pull request, when asked to perform a final code review, or when checking whether your own draft MR/PR is in good enough shape to be undrafted. It drives a practical end-of-MR review workflow focused on correctness, risk, test coverage, reviewer comments, clear review verdicts, a default two-reviewer path, and optional built-in `/fleet` orchestration for especially large or high-risk reviews.'
---

# Final Review

Use this skill for MR/PR review work.

This includes:

- reviewing someone else's merge request or pull request
- deciding whether your own draft MR is ready to be undrafted and before requesting review

This skill is normally triggered only on explicit request.

Exception:

- `auto-draft` may invoke `final-review` internally as part of its explicit autonomous draft-delivery workflow
- that exception does not make `final-review` generally auto-routable from other skills

## Relationship to Copilot CLI `/review`

GitHub Copilot CLI already provides built-in `/review`.

Use that as the default review engine when it fits, then strengthen the review with MR/PR context, CI awareness, and an explicit verdict.

## Agent Budget

Hard cap: **no more than 6 total agents** (task or explore) across the entire review.

This includes context-gathering agents, review agents, and any agents they spawn.

Typical breakdown:

- tiny fast path: 0–1 agents (review inline, maybe 1 explore for context)
- default two-reviewer path: 2–4 agents (1–2 explore for context, 2 review agents)
- `/fleet` escalation: 4–6 agents total, never more

If the MR is so large that 6 agents feel insufficient, the correct response is to split the review into explicit passes (e.g., "review security first, then correctness"), not to spawn more agents.

### Context belongs to the main agent

Gather all MR context (diff, description, CI status, file contents) yourself before launching any review agents. Read diffs and files directly with tools — do not spawn an explore agent per file.

Pass the gathered context into each review agent's prompt so reviewers can work from the provided material without re-exploring the repository.

### Review agents must not spawn sub-agents

When you launch review agents via the `task` tool, instruct them explicitly:

- do not launch sub-agents (no `task` calls, no explore agents)
- review the material provided in the prompt
- if something is unclear, note it as a gap rather than exploring independently

This is the single biggest source of agent explosion: a `general-purpose` review agent re-exploring the entire MR with its own sub-agents.

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

## Reviewer Depth

Default to two reviewers for MR / PR review so the review is as thorough as practical before handoff to humans or merge pressure.

### Tiny MR / PR fast path

For a truly tiny, coherent change, one reviewer can still be enough.

Treat this as an exception, not the norm.

Good examples:

- very small docs-only changes
- tiny typo or wording fixes
- a narrowly scoped no-risk cleanup with obvious behavior preservation

If this is your own MR and the implementation family is known, prefer a reviewer from the other model family when practical.

### Default path

For normal MR / PR review, use two reviewers.

This is especially important when:

- broad or risky diff
- non-trivial behavior changes
- security, auth, payments, deletion, migrations, or concurrency concerns
- large blast radius
- draft-undraft decision on a big branch

Suggested reviewer pair:

- `GPT-5.4 review`
- `Claude Sonnet 4.6 review`

Escalate the Claude reviewer to `Claude Opus 4.6 review` when the change is especially hard or high-risk.

Use the two-reviewer path unless the MR clearly fits the tiny fast path above.

When you use the two-reviewer path, launch separate review agents with the `task` tool instead of relying on one long self-review:

- `GPT-5.4 review`: `agent_type: "general-purpose"`, `model: "gpt-5.4"`
- `Claude Sonnet 4.6 review`: `agent_type: "general-purpose"`, `model: "claude-sonnet-4.6"`
- for especially hard or high-risk work, replace the Sonnet reviewer with `Claude Opus 4.6 review`: `agent_type: "general-purpose"`, `model: "claude-opus-4.6"`

Include the full diff and all relevant context in each reviewer's prompt. Explicitly instruct each reviewer not to launch any sub-agents — they review the material provided, nothing more.

### Large / high-risk review with built-in `/fleet`

For especially large or high-risk MRs, built-in `/fleet` can help orchestrate parallel review work.

Treat this as an escalation, not the default. The total agent count must still stay within the agent budget above.

Good `/fleet` review candidates usually have:

- clearly separated subsystems or file groups
- distinct review concerns such as security, correctness, and test coverage
- enough scope that one reviewer pair would become slow or noisy

If you use built-in `/fleet` for review:

- keep the total number of fleet tasks plus any other agents within the 6-agent budget
- define which reviewer checks which files or concern areas
- pass all needed MR context into each fleet task so they do not re-explore
- instruct fleet tasks not to launch their own sub-agents
- how duplicate comments will be deduplicated
- who synthesizes the final blocking versus advisory verdict

Do not use `/fleet` to create a pile of unsynthesized comments. Parallel review only helps if one pass combines the findings into a coherent final verdict.

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
- using `checkpoint` when the real task is MR/PR review
