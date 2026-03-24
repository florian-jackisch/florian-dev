---
name: copilot-instructions-improver
description: 'This skill should be used when the user asks to "improve copilot instructions", "audit copilot-instructions.md", "fix project instructions", "review .github/instructions", or wants to improve repository instruction files that guide GitHub Copilot. It audits repo-local instruction files, produces a quality report, and proposes targeted updates before editing them.'
---

# Copilot Instructions Improver

Audit, evaluate, and improve repository-local instruction files used by GitHub Copilot.

Use this skill for instruction files that shape Copilot behavior in a project, especially:

- `.github/copilot-instructions.md`
- `.github/instructions/**/*.instructions.md`
- `AGENTS.md` when it is intentionally used as a shared instruction file for Copilot-compatible tools

Ignore user-global instruction files unless the user explicitly asks for them.

## Workflow

### Phase 1: Discovery

Find project instruction files first.

Use focused discovery commands such as:

```bash
find .   \( -path './.git' -o -path './node_modules' \) -prune -o   \( -name 'AGENTS.md' -o -path './.github/copilot-instructions.md' -o -path './.github/instructions/*.instructions.md' \)   -print | sort
```

Classify what was found:

| File type | Typical path | Purpose |
| --- | --- | --- |
| Root project instructions | `./.github/copilot-instructions.md` | Default repository guidance for Copilot |
| Scoped instructions | `./.github/instructions/<topic>.instructions.md` | Context-specific guidance for subsets of work |
| Shared cross-tool instructions | `./AGENTS.md` | Optional repo-wide instructions used by Copilot and other tools |

If multiple files exist, inspect how responsibilities are split. Flag overlap and contradictions early.

### Phase 2: Quality Assessment

Evaluate each file using the rubric in `references/quality-criteria.md`.

Prioritize:

1. scope clarity
2. repository-specific guidance
3. actionable rules
4. conciseness
5. freshness
6. overlap/conflict management

### Phase 3: Quality Report

Always present the report **before** making edits.

Use this format:

```markdown
## Copilot Instructions Quality Report

### Summary
- Files found: X
- Average score: X/100
- Files needing update: X

### File-by-File Assessment

#### 1. ./.github/copilot-instructions.md
**Score: XX/100 (Grade: X)**

| Criterion | Score | Notes |
|-----------|-------|-------|
| Scope clarity | X/20 | ... |
| Repo specificity | X/20 | ... |
| Actionability | X/20 | ... |
| Conciseness | X/15 | ... |
| Currency | X/15 | ... |
| Overlap/conflicts | X/10 | ... |

**Issues:**
- ...

**Recommended updates:**
- ...
```

If a file is already strong, say so clearly and avoid manufacturing edits.

### Phase 4: Propose Targeted Updates

After presenting the report, ask for confirmation before editing.

Follow these rules:

1. Propose only changes that will help future Copilot sessions.
2. Keep updates short and high-signal.
3. Prefer removing stale or redundant content over adding new prose.
4. Show diffs or quoted additions for every suggested change.
5. Explain why each change improves the instruction system.

Use `references/update-guidelines.md` for what to add and what to avoid.

### Phase 5: Apply Updates

After approval:

1. edit only the files the user approved
2. preserve useful structure unless restructuring solves a real problem
3. avoid broad rewrites when a surgical improvement is enough
4. keep wording imperative and specific
5. re-check for overlap after the edits

## What Makes Great Copilot Instructions

Strong repository instruction files are:

- **specific** — tied to this repo, not generic coding advice
- **actionable** — tell Copilot exactly what to do or avoid
- **scoped** — each file has a clear purpose
- **lean** — short enough to stay readable and maintainable
- **current** — aligned with the actual codebase and workflow

Recommended sections vary by repo, but common high-value content includes:

- repository purpose
- file layout and ownership boundaries
- naming and structural conventions
- required validation steps
- repo-specific workflows
- non-obvious gotchas
- explicit constraints about generated files, commits, or tools

## Common Issues to Flag

1. files that repeat the same rules in multiple places
2. generic advice that belongs to model defaults, not repo instructions
3. stale references to removed folders, tools, or workflows
4. instructions that mention agents or files the repo no longer uses
5. contradictory guidance between `.github/copilot-instructions.md` and scoped instruction files
6. long prose blocks where a short checklist would be clearer
7. missing guidance for repo-specific workflows that repeatedly matter

## Guidance About File Scope

Use one root instruction file for broad repository behavior.

Use `.github/instructions/*.instructions.md` only when guidance is genuinely narrower, for example:

- docs-only workflows
- test-specific conventions
- release workflows
- code-generation constraints for a specific area

Do not split files just to create structure. Split only when it reduces ambiguity.

## Templates and References

Use these references while reviewing:

- `references/quality-criteria.md` — scoring rubric and red flags
- `references/templates.md` — minimal templates for common Copilot instruction files
- `references/update-guidelines.md` — examples of high-value edits

## Final Checklist

Before finishing:

- [ ] instruction files discovered
- [ ] each file scored
- [ ] report shown before editing
- [ ] user approved the edits
- [ ] proposed changes are repo-specific
- [ ] stale or conflicting guidance removed
- [ ] final files are shorter or clearer than before
