# ADR Index

This directory contains the Architecture Decision Records for Adventure Vault
Character.

## Decision Log

| ADR | Status | Summary |
| --- | --- | --- |
| [ADR-001](ADR-001-use-kotlin-for-android.md) | Superseded | Original native Android language decision. |
| [ADR-002](ADR-002-offline-first-architecture.md) | Accepted | Keep local data and local business logic authoritative. |
| [ADR-003](ADR-003-use-room-database.md) | Superseded | Original Room over SQLite persistence decision. |
| [ADR-004](ADR-004-separate-player-and-dm-apps.md) | Accepted | Keep player and DM applications separate. |
| [ADR-005](ADR-005-use-jetpack-compose-for-ui.md) | Superseded | Original Jetpack Compose UI decision. |
| [ADR-006](ADR-006-use-flutter-for-client-application.md) | Accepted | Use Flutter and Dart for the client application. |
| [ADR-007](ADR-007-use-drift-for-local-persistence.md) | Accepted | Use Drift over SQLite for local persistence. |
| [ADR-008](ADR-008-use-compendium-and-compendium-import-system-terminology.md) | Accepted | Standardize compendium and import-system terminology. |

## How To Use This Folder

- Read the ADRs in numeric order to understand how the architecture evolved.
- Treat accepted ADRs as constraints for future implementation work.
- Preserve superseded ADRs as historical context instead of deleting them.
- Add a new ADR when a decision changes architecture, platform direction, or
  delivery constraints in a durable way.

## Related Documents

- [Architecture Decisions Summary](../architecture/09-architecture-decisions.md)
- [Architecture Index](../architecture/README.md)
- [Project Index](../project/README.md)
