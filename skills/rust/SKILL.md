---
name: rust
description: 'This skill should be used alongside general execution skills for Rust implementation, refactoring, testing, or crate setup work. It favors strong type-first design, `cargo clippy` for linting, `cargo fmt` for formatting, `cargo test` for testing, low-mock test design, clear structs over unclear tuples, and idiomatic error handling.'
---

# Rust

Use this skill for Rust-specific work.

This skill complements `coding` and `refactoring`; it does not replace them.

- use `coding` for the general execution workflow
- use `refactoring` for deliberate cleanup passes
- use `rust` to apply Rust-specific design, tooling, linting, formatting, and testing preferences

This skill is intentionally opinionated, but it should still respect the repository it is working in.

## Core Defaults

Prefer these defaults unless the project already uses something else consistently:

- strong type-first design
- `cargo clippy` for linting
- `cargo fmt` or `cargo fmt --check` for formatting
- `cargo test` for verification
- explicit, structured error handling

If a repository already has a clear different workflow, follow the repository rather than forcing a new one into it.

## Linting and Formatting

Default to:

- `cargo clippy --all-targets --all-features`
- `cargo fmt --check`

When the repository uses a stricter or wrapped command, use that instead.

Common good patterns:

- fix warnings you introduce
- treat Clippy as a design aid, not just a style gate
- avoid broad formatting churn unrelated to the current change

If the project treats warnings as errors, respect that.

## Type-First Design

Prefer using the type system to make invalid states harder to represent.

This often means:

- domain-specific structs and enums instead of loose primitives
- trait-based seams instead of ad-hoc branching
- generics where they clarify the design
- borrowing over cloning when ownership does not need to move

Avoid returning unclear tuples from non-trivial functions.

An obvious pair can be fine, but if the values need names to be understood, prefer a struct.

## Ownership and Cloning

Prefer:

- borrowing over cloning
- `&str` over `String` for input parameters when ownership is not required
- slices over owned collections in read-only APIs

Do not cargo-cult this rule into unreadable lifetime gymnastics.

If a small clone makes the code materially clearer and the cost is irrelevant, it can be acceptable.

## Error Handling

Prefer explicit error handling over panic-driven flow.

Good defaults:

- `Result` and `Option`
- `?` for propagation
- `thiserror` for library-style typed errors
- `anyhow` for binaries or top-level orchestration when appropriate

Avoid `unwrap()` and `expect()` in production paths unless there is a strong, explicit invariant and the message truly helps.

## Testing

Default to `cargo test`.

Prefer:

- focused unit tests
- integration tests when they model real boundaries better
- test seams based on traits, pure helpers, or better decomposition

Mocks are acceptable while you are finding the shape of the design.

But for final tests:

- prefer refactoring over mock-heavy tests
- prefer real value types and explicit seams
- keep mocks only when there is no simpler realistic approach

Do not let mocking become a substitute for clearer design.

## Async and Concurrency

When the crate is async:

- follow the repository runtime choice
- keep blocking work out of async paths
- make cancellation, ownership, and synchronization explicit

Prefer clarity over clever concurrency.

## Documentation and Comments

Prefer:

- doc comments for public APIs
- ordinary comments for why, safety invariants, or surprising trade-offs

Do not use decorative section comments to organize a file.

If a Rust file starts needing comment banners, split it into modules instead.

Document every `unsafe` block with the safety invariants that make it correct.

## Workflow

### 1. Read the crate or workspace first

Before changing Rust code, check:

- crate or workspace layout
- existing Clippy and rustfmt setup
- test layout
- edition and feature usage
- current patterns for errors, async, and module boundaries

### 2. Follow repo conventions, then apply these preferences

Use this skill to improve decisions, not to bulldoze local patterns.

### 3. Keep the design explicit

As you implement:

- use names that match domain intent
- prefer structs and enums over positional ambiguity
- use traits and modules to keep responsibilities narrow
- let Clippy and the compiler pressure the design toward clarity

### 4. Verify honestly

When available, that often means:

- `cargo fmt --check`
- `cargo clippy --all-targets --all-features`
- `cargo test`

If the repository exposes different commands, use those instead.

## Red Flags

- using tuples where names are needed for clarity
- reaching for mocks before trying a small design refactor
- cloning by habit instead of by need
- using `unwrap()` in normal production flow
- mixing blocking work into async paths carelessly
- hiding oversized files behind decorative section comments instead of modularizing
