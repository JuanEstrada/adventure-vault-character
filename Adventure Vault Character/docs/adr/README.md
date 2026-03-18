# ADR Index

This directory contains the Architecture Decision Records for Adventure Vault
Character.

## Decision Log

| ADR | Status | Summary |
| --- | --- | --- |
| [ADR-001](ADR-001-use-kotlin-for-android.md) | Accepted | Use Kotlin as the primary Android language. |
| [ADR-002](ADR-002-offline-first-architecture.md) | Accepted | Keep local data and business logic authoritative. |
| [ADR-003](ADR-003-use-room-database.md) | Accepted | Use Room over SQLite for local persistence. |
| [ADR-004](ADR-004-separate-player-and-dm-apps.md) | Accepted | Keep player and DM applications separate. |
| [ADR-005](ADR-005-use-jetpack-compose-for-ui.md) | Accepted | Use Jetpack Compose as the primary UI toolkit. |

## How To Use This Folder

- Read the ADRs in numeric order to understand how the architecture evolved.
- Treat accepted ADRs as constraints for future implementation work.
- Add a new ADR when a decision changes architecture, platform direction, or
  delivery constraints in a durable way.

## Related Documents

- [Architecture Decisions Summary](../architecture/09-architecture-decisions.md)
- [Architecture Index](../architecture/README.md)
- [Project Index](../project/README.md)
