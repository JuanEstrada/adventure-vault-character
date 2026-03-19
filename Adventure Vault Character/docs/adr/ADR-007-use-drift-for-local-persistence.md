# ADR-007: Use Drift for Local Persistence

## Status

Accepted

## Context

Adventure Vault Character requires durable local storage for characters,
inventory, spells, imported rules content, and supporting metadata. After the
move to Flutter, the persistence approach must support an offline-first model,
structured queries, schema evolution, and a clean separation between storage
models and domain logic.

## Decision

Use Drift over SQLite as the primary local persistence mechanism.

## Consequences

Drift preserves a SQLite-backed local data model while fitting the Flutter and
Dart stack better than Android-only persistence libraries.

The architecture must still prevent persistence entities from leaking directly
into domain and UI layers. Database access patterns, migrations, and mapping
code should be isolated behind application boundaries.

This decision supersedes the Room-based persistence direction captured in
ADR-003.
