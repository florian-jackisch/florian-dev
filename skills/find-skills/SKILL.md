---
name: find-skills
description: 'This skill should be used when the user asks to "find a skill", "is there a skill for X", "install a skill", "search skills.sh", or wants to add an external skill into the current repository. It discovers skills on skills.sh, evaluates quality, and vendors the selected skill into the repository-local `skills/` directory instead of installing globally.'
---

# Find and Vendor Skills

Discover skills from the open skills ecosystem and vendor the selected skill into the current repository's `skills/` directory.

## Purpose

Use this skill to search skills on `skills.sh`, evaluate whether they are trustworthy and relevant, and install a selected skill into the current repository in a way that matches this plugin's structure.

Do **not** install skills globally with `-g` and do **not** leave skills in `./.agents/skills/`. Use the vendoring workflow below so the repository owns the installed files.

## When to Use This Skill

Use this skill when the user:

- asks "find a skill for X" or "is there a skill for X"
- asks how to add an external skill to the current repository
- wants to search `skills.sh` for reusable workflows or domain expertise
- wants to install a skill locally for the current repo instead of globally
- wants to copy and adapt a skill from the ecosystem into this plugin

## Search Workflow

### 1. Understand the need

Identify:

1. the domain (`React`, testing, docs, deployment, design, etc.)
2. the specific task (`PR review`, `write a changelog`, `create a skill`, etc.)
3. whether the request sounds common enough that an existing skill likely exists

### 2. Search skills

Start with the leaderboard or the skill page when there is already a likely source. Otherwise search with:

```bash
npx skills find <query>
```

Use focused keywords:

- `react performance`
- `pr review`
- `changelog`
- `design system`
- `gitlab ci`

### 3. Verify quality before recommending

Do **not** recommend a skill from search results alone. Verify:

1. **Install count** — prefer widely-used skills when possible
2. **Source reputation** — prefer official or well-known publishers
3. **Repository quality** — check the source repository when trust is unclear
4. **Scope fit** — make sure the skill matches the user's need and is not just vaguely related

### 4. Present options clearly

When relevant skills exist, present:

1. skill name
2. source package coordinate
3. brief purpose
4. why it looks trustworthy
5. the skill page URL

Ask for confirmation before vendoring anything into the repository.

## Install Workflow

### Core rule

Vendor skills into `./skills/<skill-name>/`.

Do **not** leave the installed copy in `./.agents/skills/`.

### Why this workflow exists

The `skills` CLI installs project-level skills into `./.agents/skills/<skill-name>/` by default. That location is useful for general agent tooling, but it does not match this repository's plugin structure.

Prefer the bundled vendoring script to convert the CLI install into a repo-owned skill directory:

```bash
scripts/vendor-skill.sh <package> <skill-name>
```

Example:

```bash
scripts/vendor-skill.sh vercel-labs/skills find-skills
```

When working inside this repository, the concrete path is:

```bash
skills/find-skills/scripts/vendor-skill.sh <package> <skill-name>
```

If the runtime does not expose the bundled script path directly, run the same
vendoring steps inline: temporary install with `npx skills add`, copy from
`./.agents/skills/<skill-name>/` into `./skills/<skill-name>/`, then clean up
the temporary directory.

### What the script does

The script:

1. creates a temporary working directory
2. runs `npx skills add <package> --skill <skill-name> --agent github-copilot --copy -y`
3. reads the installed skill from `./.agents/skills/<skill-name>/`
4. copies the entire skill directory, including support files, into `./skills/<skill-name>/`
5. removes the temporary directory

This preserves support files such as `scripts/`, `references/`, `examples/`, and `assets/` when they exist.

### Replace behavior

If the target skill already exists and replacement is intentional, use:

```bash
scripts/vendor-skill.sh --replace <package> <skill-name>
```

Do **not** overwrite an existing skill silently.

## After Vendoring

1. inspect the vendored files
2. verify `SKILL.md` frontmatter quality
3. adapt wording, defaults, and workflow to the repository's conventions
4. update `README.md` if this repository tracks its included skills
5. commit the vendored skill only after review

## Reload Behavior

After vendoring, continue the session and treat the new repository-local skill as available.

If Copilot CLI does not pick up the new skill immediately in the current session, ask the user to run:

```text
/restart
```

Use `/restart` only as a fallback when the session has not reloaded the new repository-local skill yet.

## Safety Rules

- install only after the user confirms the exact skill to vendor
- vendor one skill at a time unless the user explicitly asks for a batch
- keep the vendored directory structure intact
- do not install globally
- do not leave temporary install artifacts in the repository
- do not claim the skill is ready before checking the copied files

## Useful Commands

Search:

```bash
npx skills find <query>
```

List a package without installing:

```bash
npx skills add <package> --list
```

Vendor a skill into the repo:

```bash
scripts/vendor-skill.sh <package> <skill-name>
```

Replace an existing vendored skill:

```bash
scripts/vendor-skill.sh --replace <package> <skill-name>
```

## Common Categories

| Category | Example queries |
| --- | --- |
| Web development | `react`, `nextjs`, `tailwind`, `css` |
| Testing | `jest`, `playwright`, `e2e`, `testing` |
| DevOps | `deploy`, `docker`, `kubernetes`, `ci-cd` |
| Documentation | `readme`, `changelog`, `api-docs` |
| Code quality | `review`, `lint`, `refactor`, `best-practices` |
| Productivity | `workflow`, `automation`, `git` |

## Final Checklist

Before finishing:

- [ ] user need understood
- [ ] candidate skill searched or identified
- [ ] quality checked
- [ ] user approved installation
- [ ] skill vendored into `skills/<skill-name>/`
- [ ] copied files reviewed
- [ ] repo docs updated when needed
- [ ] user told whether `/restart` is needed
