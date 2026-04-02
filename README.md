# flow

Personal GitHub Copilot CLI plugin for lightweight personal preferences, language companions, and selectively vendored tooling components.

## Install

```text
/plugin install florian-jackisch/flow
```

## Optional Global Preferences

To install the global Copilot preferences that go with this plugin:

```bash
curl -fsSL https://raw.githubusercontent.com/florian-jackisch/flow/main/install.sh | bash
```

The installer writes a small managed block to `~/.copilot/copilot-instructions.md` that keeps:

- no `Co-authored-by` trailers for Copilot
- brief commit messages with one optional body paragraph
- `obra/superpowers` opt-in rather than always-on
- new PRs and MRs draft-first, with no automatic reviewer assignment

## Included Skills

| Skill | Description |
|-------|-------------|
| `bash` | Bash implementation and script-hardening companion with portable shebangs, quoting discipline, and shell tooling preferences |
| `cpp` | C++ companion with modern C++, CMake plus Ninja, clang tooling, and sanitizer-minded verification |
| `context7-mcp` | Use Context7 for current library and framework documentation instead of relying on stale training data |
| `mermaid` | Mermaid diagram companion for documentation, specs, and architecture notes |
| `no-superpowers` | Session opt-out that disables automatic `obra/superpowers` workflow use unless explicitly requested |
| `python` | Python companion with type hints, `uv`, `ruff`, `pytest`, and modern library preferences |
| `rust` | Rust companion with type-first design, `cargo fmt`, `cargo clippy`, and `cargo test` discipline |
| `skill-development` | Guidance for creating and refining Copilot skills |
| `writing` | Writing-focused workflow for specs, docs, runbooks, and other non-code content |

## Included Agents

| Agent | Description |
|-------|-------------|
| `docs-researcher` | Context7-backed research agent for focused library documentation lookups |

## Included Commands

| Command | Description |
|---------|-------------|
| `/context7:docs` | Manual Context7 documentation lookup for a library and optional query |

## Notes

- This plugin is intentionally lightweight, but vendored plugin parity may include agents and commands when explicitly desired.
- It is intentionally lightweight and is designed to coexist with `obra/superpowers`.
- `obra/superpowers` can own the heavyweight workflow skills; `flow` stays focused on personal preferences and reusable companions.
- If both plugins are installed and you want a lightweight session, invoke `/no-superpowers` at the start of the conversation.
- This repository keeps its external-skill vendoring helper as a repo-local skill in `.github/skills/vendor-skill`.
- This repository vendors external plugin payloads under `plugins/`; Context7 is the first example at `plugins/context7/`.
- External skills should be vendored into `skills/`, not installed globally.
- If a newly added skill does not appear immediately after reinstalling the plugin, run `/restart`.

## MCP Servers

| Server | Purpose |
|--------|---------|
| `context7` | Library documentation lookups via the vendored upstream Context7 plugin payload |
| `gitlab` | GitLab MCP via `glab mcp serve` for GitLab issues, merge requests, pipelines, and related workflows |

## Integration Notes

- Prefer Copilot CLI's built-in GitHub MCP rather than bundling a plugin-local replacement.
- The bundled GitLab MCP uses `glab mcp serve`, so `glab` must be installed and authenticated.

## License

[MIT](LICENSE)
