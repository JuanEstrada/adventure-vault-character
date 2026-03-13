# ADR-003: Use Room for Local Persistence

## Status

Accepted

## Context

Adventure Vault Character needs durable local storage for characters, spells, inventory, imported rules content, and supporting metadata. The persistence approach must work well on Android and fit a local-first model.

## Decision

Use Room as the primary local persistence mechanism, backed by SQLite.

## Consequences

Room provides a structured Android-native persistence layer with strong support for local data access patterns and schema evolution. The architecture must still prevent persistence entities from leaking directly into all domain and UI layers.
