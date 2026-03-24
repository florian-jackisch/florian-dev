# Copilot Instruction Templates

Use only the sections that are genuinely useful. Keep instruction files lean.

## Template: Root `.github/copilot-instructions.md`

```markdown
# Copilot Instructions — <repo>

<One-line statement of the repository purpose>

## Core Rules

- <repo-specific rule>
- <repo-specific rule>
- <constraint about generated files, tools, or workflow>

## Repository Layout

- `<path>` — <purpose>
- `<path>` — <purpose>

## Working Rules

- <how to validate changes>
- <how to handle documentation>
- <how to treat risky or stale patterns>
```

## Template: Scoped `.github/instructions/<topic>.instructions.md`

```markdown
---
applyTo: "<glob pattern>"
---

# <Topic> Instructions

## Scope

- Applies to <files/workflow>
- Does not apply to <other areas>

## Rules

- <specific rule>
- <specific rule>
- <validation step>
```

## Template: Shared `AGENTS.md`

Use only when the repo intentionally shares one instruction file across multiple agent tools.

```markdown
# Agent Instructions — <repo>

## Purpose

- <shared repo context>

## Core Constraints

- <shared rule>
- <shared rule>

## Repo-Specific Workflow

- <important workflow>
```

## Template Advice

- Prefer one strong root file over several weak files.
- Add scoped instruction files only when they reduce ambiguity.
- Prefer short checklists and bullet points over long explanation.
- Avoid copying the same rules into every instruction file.
