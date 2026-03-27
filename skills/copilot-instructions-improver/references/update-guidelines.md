# Copilot Instruction Update Guidelines

## Core Principle

Only add information that will materially improve future Copilot sessions in this repository.

If a line does not change behavior, remove it or avoid adding it.

## What TO Add

### 1. Repo-Specific Constraints

```markdown
- Do not add an `agents/` directory; this plugin is skills-only.
- Vendor external skills into `skills/` instead of installing them globally.
```

Why: These rules change behavior and prevent repeated mistakes.

### 2. Real Workflow Steps

```markdown
- Reinstall the plugin with `/plugin install florian-jackisch/flow` after adding a skill.
- Run `/restart` if the current session does not pick up the new skill immediately.
```

Why: Future sessions should not have to rediscover working workflow steps.

### 3. Non-Obvious Gotchas

```markdown
- `npx skills add` installs project-level skills into `./.agents/skills/` by default; copy the full installed tree into `./skills/<name>/` instead of committing `.agents/`.
```

Why: This is specific, surprising, and easy to forget.

### 4. Boundaries Between Files

```markdown
- Keep broad repo rules in `.github/copilot-instructions.md`.
- Use `.github/instructions/*.instructions.md` only for narrower file-pattern-specific guidance.
```

Why: Good boundaries reduce overlap and conflicts.

## What NOT to Add

### 1. Generic Engineering Advice

Bad:

```markdown
- Write maintainable code.
- Add tests for changes.
```

### 2. Obvious Directory Facts

Bad:

```markdown
- The `skills/` directory contains skills.
```

Only keep directory notes when they carry non-obvious workflow meaning.

### 3. Long Explanations

Bad:

```markdown
This repository uses instructions because instructions are important for guiding the model and helping future sessions remain consistent...
```

Better:

```markdown
- Keep instructions short, specific, and repo-scoped.
```

### 4. Duplicated Rules

Do not repeat the same commit or file-generation rules across every instruction file unless a scoped file truly needs to restate them.

## Diff Format for Suggested Edits

For each recommendation, show:

1. target file
2. exact addition, replacement, or deletion
3. short reason tied to future usefulness

Example:

```diff
### Update: ./.github/copilot-instructions.md

+ ## Working Rules
+ - Reinstall the plugin after adding a skill.
+ - Run `/restart` if the session does not see the new skill.
```

> Why this helps: it captures the real plugin-refresh workflow that future sessions would otherwise rediscover.

## Validation Checklist

- [ ] Each change is repo-specific
- [ ] Each change is shorter or clearer than the old wording
- [ ] File paths and workflows are current
- [ ] No stale references remain
- [ ] Overlap across instruction files is reduced, not increased
