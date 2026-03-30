---
name: python
description: 'This skill should be used for Python implementation, testing, or project setup work. It favors pervasive type hints, `ruff`, `uv`, `ty` when the project uses it, `pytest`, refactor-first test design, dataclasses over unclear tuples, and modern Python libraries such as `rich`, `typer`, and `pydantic`.'
---

# Python

Use this skill for Python-specific work.

Use `python` to apply Python-specific toolchain, typing, testing, and library preferences during Python work.

This skill is intentionally opinionated, but it should still respect the repository it is working in.

## Core Defaults

Prefer these defaults unless the project already uses something else consistently:

- type hints everywhere practical
- `ruff` for linting and formatting
- `ty` for type checking when the project is set up for it
- `uv` for project setup, dependency management, and command execution
- `pytest` for testing

If a repository already uses a different toolchain consistently, follow the repository rather than forcing these defaults into it.

## Project Setup

For new or lightly structured Python projects, prefer `uv`.

Typical patterns:

- `uv init`
- `uv add`
- `uv add --dev`
- `uv sync`
- `uv run ...`

Do not migrate an established repository from Poetry, Hatch, pip-tools, or another setup unless the user asks.

## Linting and Formatting

Default to `ruff` unless the repository clearly uses something else.

Preferred order:

1. `uv run ruff check ...`
2. `uv run ruff check --fix ...` when fixes are appropriate
3. `uv run ruff format ...`

If the project does not manage `ruff` through `uv`, use the repository's existing invocation path instead of inventing one.

Do not reformat unrelated files just because you can.

## Type Checking

Prefer explicit types on:

- function parameters
- return values
- dataclass fields
- public attributes where type intent matters

For type checking:

- if the repository already uses a checker such as `mypy`, `pyright`, or `ty`, use that checker
- if the repository wraps its checker behind another command, use the repository command
- if the repository has no checker configured, still run a type checker for the changed Python area as a local quality signal
- when you need that fallback, prefer `ty`

Treat fallback type checking as a check on the code you are changing, not as permission to normalize an entire repository.

If the fallback checker reports noise outside the touched area:

- fix issues in the code you changed
- fix untouched-code findings only when they are obviously real and tightly coupled to your change
- do not turn a local implementation task into a repo-wide type cleanup unless the user asks

Avoid weakening types just to silence a checker. Prefer clearer design, better boundaries, and narrower APIs.

## Data Modeling

Prefer:

- `dataclasses` for structured internal data
- `pydantic` for validation, parsing, external boundaries, and config-like schemas

Avoid returning unclear tuples from non-trivial functions.

An obvious pair can be fine, but if the values need names to be understood, use a dataclass or another named structure.

## Scripts and One-Off Automation

For a one-off script:

1. first ask whether the standard library is enough
2. if yes, keep it stdlib-only
3. if not, prefer a `uv` script workflow so dependencies are declared and runnable in one go

When a script genuinely needs third-party dependencies, prefer the `uv` shebang pattern instead of ad-hoc local installs.

## Testing

Default to `pytest`.

Good defaults:

- small focused tests
- readable fixtures
- parameterization when it improves clarity
- integration-style tests when they can replace brittle mocking

Mocks and `monkeypatch` are acceptable during red/green TDD while finding the right design.

But for the final test shape:

- prefer refactoring production code so tests do not need mocks or `monkeypatch`
- prefer dependency injection, helper extraction, pure functions, or clearer boundaries
- keep mocks only when there is truly no simpler realistic seam

Do not treat heavy mocking as the default architecture for Python tests.

## Design Preferences

Prefer:

- small modules over oversized files
- clear names over comment-based structure
- functional extraction when it makes state and testing simpler
- `typer` for CLIs when a real CLI is needed
- `rich` for terminal UX when richer output helps users

Do not use decorative section comments to organize a file.

If a Python file starts to need banners and dividers, split it into multiple modules instead.

## Workflow

### 1. Read the repository first

Before changing Python code, check:

- packaging and environment setup
- lint and format tools
- test framework
- type checker
- existing project conventions

### 2. Follow repo conventions, then apply these preferences

Use this skill to improve decisions, not to bulldoze local patterns.

### 3. Keep Python code easy to test and type-check

As you implement:

- add or preserve type hints
- keep boundaries explicit
- prefer named data structures over positional ambiguity
- keep module responsibilities narrow

### 4. Verify honestly

Run the checks the project actually has.

When available, that often means:

- `uv run ruff check ...`
- `uv run ruff format --check ...`
- `uv run ty ...`
- `uv run pytest ...`

If the repository exposes different commands, use those instead.

If the repository has no type checker configured, still run a scoped type check over the changed Python surface when practical and treat the result as local signal rather than repo policy.

## Red Flags

- introducing untyped public APIs without a reason
- using tuples where names are needed for clarity
- defaulting to mocks when a small refactor would remove the need
- adding third-party script dependencies when the standard library would do
- forcing `uv`, `ruff`, or `ty` into a repository with a clear different setup
- turning fallback type-checking noise into an unrelated repo-wide cleanup
- using decorative comment banners to hide a file that wants modularization
