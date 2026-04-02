---
name: vendor-plugin
description: "This skill should be used when the user asks to \"vendor a plugin\", \"bring in a Copilot plugin\", \"adapt a Claude plugin for Copilot\", \"copy an external plugin into this repo\", or \"update a vendored plugin\" in this repository."
---

# Vendor a Plugin into flow

Vendor external plugin payloads into this repository in a Copilot-compatible way while keeping the workflow itself local to this repository.

## Purpose

Use this skill to bring an upstream plugin into `flow` without pretending that Copilot supports nested plugin dependencies. Preserve upstream plugin material in a vendored subtree, then adapt the reusable pieces into `flow`'s single root `plugin.json`, aggregated `.mcp.json`, and shipped skill paths.

This workflow was derived from adapting the upstream Context7 Claude plugin from `upstash/context7`.

## When to Use This Skill

Use this skill when the task is to:

- vendor a plugin from another repository into `flow`
- adapt a Claude-oriented plugin to Copilot CLI
- replace a hand-written MCP integration with vendored plugin source material
- explain how plugin vendoring works in this repository

Do **not** use this skill to:

- install a plugin globally for the user
- leave vendored plugin files only in `~/.copilot/installed-plugins`
- add nested plugin dependencies and expect Copilot to compose them automatically

## Repository Rules

- `flow` is a **single root plugin** with `plugin.json` at the repository root.
- Vendored plugin source material belongs under `./plugins/<plugin-name>/`.
- Preserve upstream plugin provenance by keeping only the key source files needed for adaptation and future updates.
- Adapt vendored functionality through the root plugin files instead of trying to install nested plugins.
- Keep repo-maintenance instructions local under `.github/skills/`.
- Vendored agents and commands are allowed when they are part of an intentional upstream-parity adaptation.
- Treat the root `.mcp.json` as the aggregate MCP config for all vendored plugins and shared servers.

## What "Copilot-compatible" Means Here

Copilot CLI can install a plugin from a directory that contains `plugin.json`, but `flow` itself is already the installable plugin. There is no nested-plugin composition layer inside `flow`.

To vendor another plugin into this repository:

1. copy the upstream plugin payload into `./plugins/<plugin-name>/`
2. keep reusable files for provenance and future updates
3. wire supported pieces into `flow`'s root plugin

In practice:

- vendored **skills** can be added through `plugin.json` path arrays
- vendored **agents** can be added through `plugin.json` path arrays, but may need filename translation to Copilot's `.agent.md` convention
- vendored **commands** must be declared in `plugin.json`; there is no default `commands/` path
- vendored **MCP config** must be merged into the root `.mcp.json`
- vendored **plugin manifests** may need small Copilot-specific adaptation so direct installs load the expected component paths

## Workflow

### 1. Inspect the upstream plugin

Identify:

1. the source repository
2. the path to the upstream plugin payload inside that repository
3. whether the upstream payload includes:
   - plugin manifest
   - MCP config
   - skills
   - agents
   - commands

For Context7, the useful upstream payload is:

```text
upstash/context7:plugins/claude/context7
```

### 2. Run the bundled vendoring script

Run:

```bash
.github/skills/vendor-plugin/scripts/vendor-plugin.sh <source-repo> <plugin-path> <plugin-name>
```

Example:

```bash
.github/skills/vendor-plugin/scripts/vendor-plugin.sh upstash/context7 plugins/claude/context7 context7
```

Replace an existing vendored plugin intentionally:

```bash
.github/skills/vendor-plugin/scripts/vendor-plugin.sh --replace upstash/context7 plugins/claude/context7 context7
```

Pass an explicit repository root only when the command is being run from elsewhere:

```bash
.github/skills/vendor-plugin/scripts/vendor-plugin.sh upstash/context7 plugins/claude/context7 context7 /path/to/repo
```

### 3. Review what the script copied

The script is intentionally conservative. It vendors the plugin pieces that fit `flow`'s structure:

- `.claude-plugin/plugin.json`
- `.mcp.json`
- `skills/`
- `agents/`, translated to Copilot's `.agent.md` naming convention when needed
- `commands/`

`README.md` is **optional**. Do not copy it by default just for bookkeeping. Only keep an upstream README when it contains information that is genuinely needed to maintain or update the vendored plugin.

If the upstream payload contains unsupported pieces beyond these, document that gap before claiming the vendoring is complete.

### 4. Adapt the vendored plugin into `flow`

After the upstream payload is copied into `./plugins/<plugin-name>/`, wire it into the published plugin:

1. update the root `plugin.json`
2. merge the vendored MCP definition into the root `.mcp.json`
3. add vendored skill directories to the root `skills` path array when needed
4. add vendored agent directories to the root `agents` path array when needed
5. add vendored command directories to the root `commands` path array when needed
6. update `README.md` and `.github/copilot-instructions.md`
7. bump `plugin.json` version if the shipped plugin surface changes

Important constraint:

- `plugin.json` can point to multiple skill directories, but only one MCP config path, so MCP settings must be aggregated at the root

### 5. Preserve upstream behavior where reasonable

Aim to keep the vendored plugin close to upstream behavior:

- preserve MCP behavior when the upstream plugin is MCP-backed
- preserve upstream skill wording unless repository conventions require adjustment
- preserve upstream command behavior when Copilot supports it
- preserve upstream agent behavior when parity is required and the adaptation is still lightweight
- keep only upstream metadata files that materially help with provenance or future updates

Do not violate repository rules just to be literal:

- translate file names or manifest fields when Copilot compatibility requires it
- avoid adding unrelated heavyweight workflow components that do not fit `flow`

### 6. Validate and reload

After vendoring or updating a plugin:

1. reinstall the root plugin:
   ```text
   /plugin install florian-jackisch/flow
   ```
2. check `/skills`
3. verify the expected MCP integration is still present
4. use `/restart` or `/skills reload` only if the current session does not pick up the changes automatically

## Safety Rules

- Do **not** install nested plugins and leave them in CLI cache as the source of truth.
- Do **not** silently overwrite an existing vendored plugin; use `--replace`.
- Do **not** leave root MCP aggregation undocumented when new vendored plugins are added.
- Vendor one plugin at a time unless the user explicitly requests a batch.

## Additional Resources

- **`scripts/vendor-plugin.sh`** — copies a supported upstream plugin payload into `./plugins/<plugin-name>/`
