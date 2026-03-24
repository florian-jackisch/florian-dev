---
name: bash
description: 'This skill should be used alongside general execution skills for Bash implementation, refactoring, script hardening, automation, or CLI glue work. It favors portable `#!/usr/bin/env bash` shebangs with immediate `set -euo pipefail`, `shellcheck` for linting, `shfmt` for formatting, executable scripts, careful quoting, arrays over unsafe word splitting, and small function-based script structure.'
---

# Bash

Use this skill for Bash-specific work.

This skill complements `coding` and `refactoring`; it does not replace them.

- use `coding` for the general execution workflow
- use `refactoring` for deliberate cleanup passes
- use `bash` to apply shell-specific design, safety, linting, formatting, and script-hardening preferences

This skill is intentionally opinionated, but it should still respect the repository it is working in.

## Core Defaults

Prefer these defaults unless the project already uses something else consistently:

- `#!/usr/bin/env bash`
- `set -euo pipefail` immediately after the shebang for fail-fast behavior
- `shellcheck` for linting
- `shfmt` for formatting
- executable scripts when the file is meant to be run directly

If a repository already has a clear different workflow, follow the repository rather than forcing a new one into it.

## Shebang and Fail-Fast Setup

Default to:

```bash
#!/usr/bin/env bash
set -euo pipefail
```

Prefer this over pushing shell options into the shebang itself.

It is more portable and easier to read across environments.

If a script intentionally needs different semantics, make that explicit rather than silently weakening the defaults.

If a file is meant to be sourced rather than executed directly, do not unconditionally change the caller's shell options.

When a script is meant to be executed directly, make sure it is executable.

## Linting and Formatting

Default to:

- `shellcheck` for linting and bug-finding
- `shfmt` for formatting

Use the repository's wrapped commands when they exist.

Important:

- `shellcheck` is the linter; do not treat it as the primary formatter
- `shfmt` should own formatting
- fix warnings you introduce
- avoid broad formatting churn unrelated to the task

If the project has no wrapped verification flow, still run `shellcheck` and `shfmt` on the changed script area when practical.

## Structure and Readability

Prefer:

- small focused scripts
- small functions over long linear files
- clear names over clever shell tricks
- helper functions for repeated behavior

Do not use decorative section comments to organize a script.

If a script needs banners and dividers to stay readable, split logic into smaller functions or separate scripts.

## Safety and Quoting

Prefer:

- quoting parameter expansions unless unquoted behavior is intentional
- arrays for argument lists
- `"$@"` for forwarding arguments
- `[[ ... ]]` for Bash conditionals
- `case` when branching on structured string values

Avoid:

- unsafe word splitting
- unnecessary `eval`
- parsing `ls`
- pipelines that hide failures accidentally

Use `IFS` changes sparingly and keep them local when possible.

Be careful with `set -u` and empty arrays on older Bash versions, especially macOS's default Bash 3.2.

If an array may legitimately be empty, do not assume `"${arr[@]}"` is always safe under `set -u`.

Prefer checking array length first or using a compatibility-safe expansion pattern when older Bash support matters.

## Data Flow and Commands

Treat shell as orchestration glue first.

Prefer:

- standard Unix tools used clearly and intentionally
- explicit pipelines
- small helpers for repeated command composition
- early validation of required commands, files, and arguments

If a script is becoming data-heavy, algorithm-heavy, or hard to test, consider whether Bash is still the right tool.

Do not force complex application logic into shell just because the entry point is a script.

## Error Handling

With `set -euo pipefail`, be deliberate about commands that may legitimately return non-zero status.

Prefer:

- explicit guards
- `if ! command; then ... fi` when failures are expected and handled
- clear error messages to stderr
- cleanup via `trap` when temporary files or other resources must be released

Do not weaken the script globally with `set +e` unless there is a strong, local reason and the surrounding flow makes the behavior obvious.

## Portability and Bash Specificity

Use Bash intentionally.

Prefer Bash features when they make the script safer or clearer:

- arrays
- `[[ ... ]]`
- parameter expansion
- associative arrays when appropriate

But do not accidentally write code that claims to be generic `sh` while depending on Bash behavior.

If the script is Bash, say so with the shebang and write Bash clearly.

## Testing and Verification

Shell tests vary a lot by repository.

Prefer the repository's existing test setup first.

When no dedicated shell test harness exists, verification often still means:

- run `shellcheck`
- run `shfmt` in check or diff mode
- execute the script against realistic sample inputs
- verify failure paths and edge cases, not just the happy path

Prefer small refactors and helper extraction over brittle mock-heavy shell tests.

## Workflow

### 1. Read the script and its calling context first

Before changing Bash code, check:

- shebang and shell assumptions
- how the script is invoked
- external commands it depends on
- environment variables and argument contract
- existing lint and format setup
- file permissions if it should be executable

### 2. Follow repo conventions, then apply these preferences

Use this skill to improve decisions, not to bulldoze local patterns.

### 3. Keep shell code explicit

As you implement:

- validate inputs early
- keep quoting intentional
- prefer arrays over stringly command construction
- keep functions narrow
- make failure paths obvious

### 4. Verify honestly

Run the checks the project actually has.

When available, that often means:

- `shellcheck path/to/script.sh`
- `shfmt -d path/to/script.sh`
- `chmod +x path/to/script.sh` when the file should be executable
- executing the script with realistic arguments

If the repository exposes different commands, use those instead.

If the project has no wrapped verification flow, still run the relevant lint, format, permission, and execution checks on the changed script area when practical.

## Red Flags

- missing `set -euo pipefail` in a new directly executed Bash script without a reason
- pretending a Bash script is POSIX `sh` while using Bash-only features
- using strings where arrays should hold argument lists
- relying on unquoted expansions accidentally
- reaching for `eval` instead of clearer command construction
- using decorative comment banners to hide a script that wants functions or decomposition
- forgetting to make a directly-invoked script executable
