# Copilot Instructions — flow

This repository is a **skills-only** GitHub Copilot CLI plugin.

## Plugin Identity

- Name: `flow`
- Install: `/plugin install florian-jackisch/flow`
- Format: standalone plugin with `plugin.json` at repo root
- Scope: curated repo-local skills plus shared MCP config

## Repository Layout

```text
flow/
├── plugin.json
├── install.sh
├── .mcp.json
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md
│       └── [scripts|references|examples|assets]
├── .github/
│   ├── copilot-instructions.md
│   └── skills/
│       └── <local-skill>/
│           ├── SKILL.md
│           └── [scripts|references|examples|assets]
├── README.md
└── LICENSE
```

## Core Rules

- This plugin does **not** use agents. Do not add an `agents/` directory or an `agents` entry to `plugin.json`.
- Keep names lowercase-kebab-case.
- Keep skill `name` equal to the folder name.
- Write skill descriptions in third person with concrete trigger phrases.
- Prefer repo-local skills. Do **not** install skills globally.
- Use `copilot-instructions-improver` when auditing or rewriting this repo's Copilot instruction files.

## Scope and Coexistence

- `flow` is intentionally lightweight.
- `flow` owns personal preferences, language companions, documentation helpers, and skill-authoring tooling.
- `obra/superpowers` can own heavyweight workflow skills such as brainstorming, planning, TDD, review, and worktree orchestration.
- Do not reintroduce worktree, planning, implementation-review, or other heavyweight workflow skills here unless explicitly requested.
- The `no-superpowers` skill is the session-level opt-out when both plugins are installed.

## Adding or Adapting a Skill

1. Create `skills/<skill-name>/SKILL.md`.
2. Add YAML frontmatter:
   - `name`
   - `description`
3. Add optional support files only when useful:
   - `scripts/`
   - `references/`
   - `examples/`
   - `assets/`
4. If the skill comes from `skills.sh`, vendor it into `skills/` instead of keeping any `.agents/` install output.
5. Update `README.md` when relevant.
6. Bump `plugin.json` version before pushing.

## Repo-Local Vendoring Helper

- The vendoring workflow for this repository now lives in the local-only `vendor-skill` skill under `.github/skills/vendor-skill/`.
- Use that local skill when asked to vendor or update an external skill in this repository.
- Keep published plugin skills in `./skills/<skill-name>/`.
- Do not install skills globally or keep `.agents/skills` artifacts in the repository.
- Review vendored files before committing.

## Global Preference Installer

- Keep `install.sh` idempotent.
- It should manage a clearly marked block inside `~/.copilot/copilot-instructions.md`.
- The managed block should express the personal defaults that should apply across repositories:
  - no `Co-authored-by` trailers for Copilot
  - brief commit messages with one optional body paragraph
  - `obra/superpowers` is opt-in unless explicitly requested
  - draft-first PR/MR behavior with no automatic reviewer assignment

## MCP Notes

- Context7 is part of the normal workflow, not an optional extra. Prefer it for current library and framework API lookups when the task depends on external APIs.
- Prefer Copilot CLI's built-in GitHub MCP instead of bundling a duplicate GitHub integration here.
- This plugin may bundle a GitLab MCP via `glab mcp serve`; keep that config simple and document the authentication prerequisite in `README.md`.

## Versioning

- Patch: documentation updates, description tweaks, non-breaking skill refinements
- Minor (`0.x.0`): new skill added
- Major (`x.0.0`): breaking removals, renamed skills, or scope changes that remove previously shipped workflow behavior

## Commit Conventions

- Single summary line, max 72 characters
- One optional explanatory body paragraph is allowed when useful
- No conventional-commit prefixes
- No `Co-authored-by` trailers

## Issues and Merge Requests

- Never create a new issue unless the user explicitly asks.
- Never create, edit, or comment on an issue or MR unless the user explicitly asks for that action.
- New MRs should always start as draft.
- Never undraft an MR automatically.
- Never assign reviewers automatically.
- Keep issue and MR descriptions short and human rather than changelog-like.

## Local Verification

After changes:

1. Reinstall the plugin:
   ```text
   /plugin install florian-jackisch/flow
   ```
2. Check `/skills` to confirm the expected skill list.
3. Optionally run `./install.sh` to refresh the managed global preferences block.
4. If the current session does not pick up a new skill immediately, run `/restart`.
