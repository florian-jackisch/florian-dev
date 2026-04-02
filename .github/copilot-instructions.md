# Copilot Instructions — flow

This repository is a lightweight GitHub Copilot CLI plugin centered on skills, MCP servers, and selectively vendored plugin components.

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
├── plugins/
│   └── <plugin-name>/
│       ├── .claude-plugin/plugin.json
│       ├── .mcp.json
│       ├── skills/
│       │   └── <skill-name>/SKILL.md
│       ├── agents/
│       │   └── <agent-name>.agent.md
│       └── commands/
│           └── <command>.md
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

- Keep names lowercase-kebab-case.
- Keep skill `name` equal to the folder name.
- Write skill descriptions in third person with concrete trigger phrases.
- Prefer repo-local skills. Do **not** install skills globally.
- Keep top-level plugin components lightweight. Only add vendored agents or commands when upstream parity is explicitly desired.

## Scope and Coexistence

- `flow` is intentionally lightweight.
- `flow` owns personal preferences, language companions, documentation helpers, and skill-authoring tooling.
- Keep heavyweight workflow orchestration out of `flow`; it should stay focused on personal preferences and reusable companions.
- Do not reintroduce worktree, planning, implementation-review, or other heavyweight workflow skills here unless explicitly requested.
- Vendored agents or commands are allowed when they are part of an intentional upstream plugin adaptation, such as Context7 parity.

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

## Vendored Plugins

- Keep vendored plugin source material under `./plugins/<plugin-name>/`.
- Adapt vendored plugins into `flow`'s single root plugin instead of trying to compose nested plugins.
- Add vendored skill paths through the root `plugin.json`.
- Add vendored agent and command paths through the root `plugin.json` when exact upstream parity is required.
- Aggregate vendored MCP definitions in the root `.mcp.json`; it remains the Copilot-facing source of truth for MCP servers.
- Use the local-only `vendor-plugin` skill under `.github/skills/vendor-plugin/` when asked to vendor or update an external plugin.
- The vendored Context7 payload comes from `upstash/context7:plugins/claude/context7`.

## Global Preference Installer

- Keep `install.sh` idempotent.
- It should manage a clearly marked block inside `~/.copilot/copilot-instructions.md`.
- The managed block should express the personal defaults that should apply across repositories:
  - no `Co-authored-by` trailers for Copilot
  - brief commit messages with one optional body paragraph
  - lightweight default workflow with no automatic extra orchestration unless explicitly requested
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
