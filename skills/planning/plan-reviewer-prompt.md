# Plan Reviewer Prompt

Use this prompt when reviewing an implementation plan before coding begins.

## Dispatch Guidance

The orchestrating agent should launch a focused review sub-agent using:

- `agent_type: "general-purpose"`
- `model: "gpt-5.4"`
- an explicit label such as `GPT-5.4 plan review`

Populate the sections below before dispatching. Do not send the template with placeholders still intact.

## Goal

Verify that the plan is specific, executable, and aligned with the idea or requirements.

## Plan / Requirements

**Plan to review:**
[paste the plan, or provide a precise path and relevant excerpt]

**Requirements / source idea:**
[paste the requirements, spec, or summary the plan must satisfy]

## Review Focus

Check for:

- missing requirements or hidden scope gaps
- vague tasks that an implementer could interpret several ways
- missing file-level guidance where specificity matters
- bad task ordering
- missing red/green test flow
- missing verification steps
- missing branch or commit discipline
- hidden risk that should appear in the plan

## Calibration

Only flag issues that would materially harm execution.

Do not block approval for stylistic preferences, phrasing tweaks, or extra nice-to-have ideas.

## Output Format

## Plan Review

**Status:** Approved | Issues Found

**Issues:**
- [Task or section]: [problem] - [why it matters]

**Recommendations:**
- [optional non-blocking suggestion]
