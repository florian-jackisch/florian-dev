---
name: cpp
description: 'This skill should be used alongside general execution skills for C++ implementation, refactoring, testing, benchmarking, profiling, build setup, or dependency management work. It favors modern C++ within the target standard, CMake with Ninja, `clang-format`, `clang-tidy`, sanitizer-backed verification, Catch2 or GoogleTest, Google Benchmark when profiling matters, balanced use of templates and header-only libraries, and clear named types over unclear tuples.'
---

# C++

Use this skill for C++-specific work.

This skill complements `coding` and `refactoring`; it does not replace them.

- use `coding` for the general execution workflow
- use `refactoring` for deliberate cleanup passes
- use `cpp` to apply C++-specific design, build, tooling, dependency, and testing preferences

This skill is intentionally opinionated, but it should still respect the repository it is working in.

## Core Defaults

Prefer these defaults unless the project already uses something else consistently:

- modern C++ within the repository's target standard
- CMake as the build system
- Ninja as the generator when practical
- `clang-format` for formatting
- `clang-tidy` for linting
- sanitizer-backed verification when the toolchain supports it
- Catch2 or GoogleTest for testing

If a repository already has a clear different workflow, follow the repository rather than forcing a new one into it.

## Build and Project Setup

For new or lightly structured C++ projects, prefer CMake.

Good defaults often include:

- out-of-source builds
- `-G Ninja` when Ninja is available
- `CMAKE_EXPORT_COMPILE_COMMANDS=ON`
- target-based CMake instead of directory-wide flags

Prefer project commands first.

If the repository does not already wrap configuration and build steps, a typical fallback is:

1. `cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON`
2. `cmake --build build`
3. `ctest --test-dir build`

Do not migrate an established repository away from Bazel, Meson, plain Make, or another existing build system unless the user asks.

## Dependencies and Package Management

If the project already uses a package manager, stay with it.

For new or lightly structured C++ work, `conan` and `vcpkg` are both good defaults.

Prefer:

- the repository's current package manager first
- small, well-maintained libraries over custom reinvention
- header-only libraries when they materially simplify integration

Do not reach for a header-only library by default if it would create heavy compile-time cost, poor build hygiene, or awkward implementation structure.

If a design fits better with implementation in `.cpp` files, prefer that over forcing everything into headers.

## Formatting and Linting

Default to:

- `clang-format`
- `clang-tidy`

When the repository uses wrapped commands or a different formatter or linter, use those instead.

Good defaults:

- format only the touched area unless the task is explicitly broader
- treat `clang-tidy` as design pressure, not just style noise
- fix warnings you introduce
- keep `compile_commands.json` available when `clang-tidy` needs it

If the project has no wrapped verification flow, still run `clang-format` and `clang-tidy` in the changed area when practical.

## Modern C++ Design

Prefer clear, modern C++ that matches the repository's target standard.

This often means:

- RAII for ownership and cleanup
- standard library facilities before custom utility layers
- templates and concepts when they clarify generic intent
- explicit named structs, classes, and enums over positional ambiguity

Avoid returning unclear tuples from non-trivial functions.

An obvious pair can be fine, but if the values need names to be understood, prefer a struct or class.

Do not use modern features as decoration.

If a repository targets an older standard, work well within that standard instead of backporting your favorite C++20 or C++23 patterns awkwardly.

## Templates and Header-Only Code

Templates are often the right tool for generic libraries and zero-overhead abstractions.

Header-only code can also make integration easier.

But prefer balance:

- use templates when the abstraction is genuinely generic
- use header-only patterns when they materially improve reuse or distribution
- move implementation into `.cpp` files when it keeps compile times, readability, and ownership boundaries healthier

Do not turn normal runtime code into template-heavy machinery without a clear payoff.

## Error Handling and Resource Safety

Prefer explicit ownership and cleanup.

Good defaults:

- RAII
- smart pointers when ownership is dynamic
- values and references when ownership does not need heap allocation
- exceptions or status-return patterns used consistently with repo conventions

Avoid mixing incompatible error-handling styles casually inside the same slice.

Do not introduce raw `new` and `delete` unless there is a strong, local reason and the codebase already works at that level.

## Testing

Prefer the repository's existing test framework.

For new or lightly structured work:

- prefer Catch2
- GoogleTest is also fine, especially when it matches the project already
- use Google Benchmark when benchmarking is part of the task

Prefer:

- focused unit tests
- integration tests where real boundaries matter
- test seams built from clearer design, not from mock-first architecture

Mocks are acceptable while finding the shape of the design.

But for the final test shape:

- prefer refactoring over mock-heavy tests
- prefer clearer interfaces and better decomposition
- keep mocks only when there is no simpler realistic seam

Do not let tests become tightly coupled to incidental implementation details.

## Sanitizers and Runtime Verification

Sanitizers are a strong recommendation whenever the toolchain and project support them.

Prefer using them especially for:

- memory safety issues
- undefined behavior risk
- concurrency-sensitive code
- pointer-heavy or lifetime-sensitive refactors

Good defaults often include:

- AddressSanitizer
- UndefinedBehaviorSanitizer
- ThreadSanitizer when concurrency is involved

If the repository already exposes sanitizer presets or targets, use those.

If it does not, consider a targeted sanitizer build when the task touches risky code rather than pretending runtime verification happened.

## Documentation and Comments

Prefer:

- comments for invariants, ownership, lifetime assumptions, and surprising trade-offs
- small headers and source files with clear responsibilities

Do not use decorative section comments to organize a file.

If a C++ file starts needing banners and dividers, split it into smaller units instead.

## Workflow

### 1. Read the repository first

Before changing C++ code, check:

- target C++ standard
- compiler and platform expectations
- build system and generator
- formatter and linter setup
- test framework
- dependency management
- current project conventions around ownership and error handling

### 2. Follow repo conventions, then apply these preferences

Use this skill to improve decisions, not to bulldoze local patterns.

### 3. Keep the design explicit

As you implement:

- use names that match domain intent
- prefer named types over positional ambiguity
- keep templates justified
- choose header-only versus `.cpp` implementation deliberately
- let tooling pressure the design toward clarity

### 4. Verify honestly

Run the checks the project actually has.

When available, that often means:

- `cmake -S . -B build -G Ninja`
- `cmake --build build`
- `ctest --test-dir build`
- `clang-format`
- `clang-tidy`
- sanitizer-backed test runs

If the repository exposes different commands, use those instead.

If the project has no wrapped verification flow, still run the relevant build, test, formatting, linting, and sanitizer checks on the changed area when practical.

## Red Flags

- forcing a newer C++ style than the target standard supports
- reaching for templates where ordinary code would be clearer
- forcing everything into headers when `.cpp` files would simplify the design
- using tuples where names are needed for clarity
- defaulting to mocks before trying a small design refactor
- pretending sanitizer coverage happened when it did not
- broad formatting churn unrelated to the task
- hiding oversized files behind decorative section comments instead of modularizing
