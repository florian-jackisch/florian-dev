# florian-dev

Personal GitHub Copilot CLI plugin with curated repo-local skills for everyday development.

## Install

```text
/plugin install florian-jackisch/florian-dev
```

## Included Skills

| Skill | Description |
|-------|-------------|
| `skill-development` | Guidance for creating effective skills — structure, frontmatter, progressive disclosure, and validation |
| `find-skills` | Search skills.sh, evaluate results, and vendor selected skills into the repo-local `skills/` directory |
| `copilot-instructions-improver` | Audit and improve repo-local GitHub Copilot instruction files, produce a quality report, and propose targeted edits |
| `debugging` | Evidence-first debugging with root-cause analysis, minimal hypothesis testing, and fix verification |
| `git` | Git hygiene, commit workflow, and MR authoring policy with human commit messages, draft-first MRs, user-reviewed MR text updates, no conventional prefixes, and no `Co-authored-by` trailers |
| `auto-draft` | Autonomous draft-delivery workflow that internally brainstorms and plans, implements on a fresh branch, opens a new draft MR, runs a capped final-review fix loop, and leaves the result as a manual-review draft |
| `python` | Python-specific companion workflow with type hints, scoped type checking, `uv`, `ruff`, `pytest`, refactor-first testing, and modern library preferences such as `dataclasses`, `rich`, `typer`, and `pydantic` |
| `rust` | Rust-specific companion workflow with type-first design, `cargo clippy`, `cargo fmt`, `cargo test`, low-mock testing, and clearer structs over unclear tuples |
| `cpp` | C++-specific companion workflow with modern C++, CMake plus Ninja, `clang-format`, `clang-tidy`, sanitizer-backed verification, Catch2 or GoogleTest, Google Benchmark when profiling matters, refactor-first low-mock testing, and balanced use of templates and header-only libraries |
| `bash` | Bash-specific companion workflow with portable shebang plus `set -euo pipefail`, `shellcheck`, `shfmt`, executable scripts, careful quoting, arrays over unsafe word splitting, and explicit shell error handling |
| `planning` | Implementation planning with exact files, red/green/refactor task structure, feature-branch discipline, built-in `/fleet` suggestions for well-bounded independent parallel work, and plan review before execution |
| `coding` | Execution workflow with branch hygiene, reuse-first coding, red/green/refactor cadence, deliberate cleanup when needed, and verification |
| `refactoring` | Behavior-preserving cleanup workflow for small in-cycle refactors and deliberate pre-review refactoring checkpoints |
| `checkpoint` | In-progress review checkpoint for planning or implementation, with one opposite-family reviewer by default, plan/slice awareness, refactoring-pressure checks, and a fast fix-and-continue loop |
| `final-review` | Heavy MR/PR review workflow for reviewing others' changes or deciding whether your own draft is ready to undraft, with a default two-reviewer path, a tiny-change fast path, and optional `/fleet` escalation for especially large or high-risk reviews |
| `writing` | Writing workflow for specs, docs, runbooks, and other non-code tasks with audience and accuracy focus |
| `mermaid` | Mermaid diagram companion workflow for Markdown docs and plans, with diagram-type selection, focused syntax, maintainable embedded diagrams, and a docs-first bias over polished rendering pipelines |
| `brainstorming` | Free-form ideation with light structure, critical questions, and web research without forcing specs |
| `interview` | Deep requirement clarification through structured follow-up questions and research loops |
| `devils-advocate` | Pre-commitment adversarial reasoning to challenge choices before they harden |

## Notes

- This plugin is **skills-only**. It does not ship agents.
- External skills should be vendored into `skills/`, not installed globally.
- If a newly added skill does not appear immediately after reinstalling the plugin, run `/restart`.

## MCP Servers

| Server | Purpose |
|--------|---------|
| `context7` | Library documentation lookups |
| `gitlab` | GitLab MCP via `glab mcp serve` for GitLab issues, merge requests, pipelines, and related workflows |

## Integration Notes

- `context7` should be part of normal planning and implementation workflow for current library and framework API lookups rather than treated as an optional separate skill.
- `auto-draft` is an explicit fast-path exception, not the default workflow. It may create or update draft MR text directly because the user opted into that autonomous flow, but it still must keep the MR as draft and unassigned.
- GitHub integration should generally use Copilot CLI's built-in GitHub MCP rather than a plugin-local replacement.
- The bundled GitLab MCP uses `glab mcp serve`, so `glab` must be installed and authenticated.

## License

[MIT](LICENSE)
