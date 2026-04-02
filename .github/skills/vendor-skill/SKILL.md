---
name: vendor-skill
description: "This skill should be used when the user asks to \"vendor a skill\", \"bring in a skill from skills.sh\", \"copy a skill into this plugin\", \"add an external skill locally\", or \"update a vendored skill\" in this repository."
---

# Vendor a Skill into flow

Vendor external skills into this repository's published `skills/` directory while keeping the vendoring helper itself local to this repository.

## Purpose

Use this skill to bring an external skill into the `flow` plugin in the same way the existing vendored skills were added. Keep the workflow local under `.github/skills/vendor-skill/` so the published plugin does not ship repository-maintenance instructions as part of its public skill surface.

## When to Use This Skill

Use this skill when the task is to:

- add a new external skill to this repository
- refresh an already vendored skill from its upstream package
- explain or repeat the vendoring workflow used in this repository

Do **not** use this skill to:

- install skills globally with `-g`
- leave copied skills in `.agents/skills/`
- create a brand-new repo-local helper skill under `.github/skills/`

## Repository Rules

- Vendor published plugin skills into `./skills/<skill-name>/`.
- Keep this helper skill local at `.github/skills/vendor-skill/`.
- Preserve the full installed skill tree when vendoring so support files such as `scripts/`, `references/`, `examples/`, and `assets/` come across intact.
- Review the copied files before committing.
- Update plugin documentation or versioning only when the published plugin surface changes.

## Workflow

### 1. Confirm the source

Identify:

1. the package coordinate, for example `vercel-labs/skills`
2. the exact skill name inside that package
3. whether the target already exists in `./skills/`

If the package contains multiple skills and the exact skill name is unclear, inspect it first:

```bash
npx skills add <package> --list
```

### 2. Run the bundled vendoring script

Run the script that comes with this local skill:

```bash
.github/skills/vendor-skill/scripts/vendor-skill.sh <package> <skill-name>
```

Replace an existing vendored skill intentionally:

```bash
.github/skills/vendor-skill/scripts/vendor-skill.sh --replace <package> <skill-name>
```

Pass an explicit repository root only when the command is being run from an unusual working directory:

```bash
.github/skills/vendor-skill/scripts/vendor-skill.sh <package> <skill-name> /path/to/repo
```

### 3. Understand what the script does

The script:

1. creates a temporary working directory
2. runs `npx skills add <package> --skill <skill-name> --agent github-copilot --copy -y`
3. reads the installed copy from `.agents/skills/<skill-name>/` inside that temporary directory
4. copies the full installed tree into `./skills/<skill-name>/`
5. removes the temporary directory automatically

This keeps transient `.agents` output out of the repository while still producing a repo-owned copy of the skill.

### 4. Review the vendored files

Inspect the copied skill directory and adapt it to this repository's conventions:

1. confirm `SKILL.md` exists and has valid frontmatter
2. check trigger phrases, naming, and wording
3. review bundled scripts before trusting or pre-approving them
4. remove upstream cruft only when it is clearly unrelated to the skill's behavior
5. keep the directory structure intact when support files are actually used

### 5. Update repo-facing files when needed

When the published plugin surface changes, update the files that describe shipped behavior:

- `README.md`
- `plugin.json`
- `.github/copilot-instructions.md` when the repository guidance should point at the new or updated workflow

Follow this repository's versioning rules:

- adding a shipped skill is a minor version bump
- removing or renaming a shipped skill is a major version bump
- documentation-only changes are patch bumps

### 6. Reload and verify

After vendoring or updating a shipped skill:

1. reinstall the plugin:
   ```text
   /plugin install florian-jackisch/flow
   ```
2. check `/skills`
3. use `/restart` only if the current session fails to pick up the change automatically

## Safety Rules

- Do **not** install skills globally.
- Do **not** commit `.agents/` output.
- Do **not** overwrite an existing skill silently; use `--replace` explicitly.
- Vendor one skill at a time unless a batch is explicitly requested.
- Keep skill names lowercase-kebab-case.
- Treat this skill as repo-local tooling, not as part of the published plugin.

## Additional Resources

- **`scripts/vendor-skill.sh`** — deterministic vendoring helper for this repository
