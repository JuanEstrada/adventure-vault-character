# ADR-003: Use Room for Local Persistence

## Status

Superseded by [ADR-007](ADR-007-use-drift-for-local-persistence.md)

## Context

Adventure Vault Character originally planned local persistence around the
Android-native toolchain and needed structured storage for characters, spells,
inventory, imported rules content, and supporting metadata.

## Decision

Use Room as the primary local persistence mechanism, backed by SQLite.

## Consequences

This decision fit the original native Android direction. It remains part of
the architecture history, but it is no longer active after adopting Flutter
and Drift in ADR-006 and ADR-007.
